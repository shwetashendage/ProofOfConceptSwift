//
//  POCServiceClass.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 12/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

//Parser
import SwiftyJSON

class POCServiceClass{
    
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    var factsArray : [POCFacts] = []
    typealias JSONDictinary = [String : Any]
    typealias factsResult = ([POCFacts]?, String, String) -> ()
    var headerTitle = ""
    
    
    func getResults(completion: @escaping factsResult) {
        
        dataTask?.cancel()
        
        guard let url = URL(string:POCConstants.POCUrl) else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer {
                self.dataTask = nil
                
            }
            
            if let error = error {
                self.errorMessage += "Error cause: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                //JSON Parsing call
                self.createFactsArray(data)
            }
            DispatchQueue.main.async {
                completion(self.factsArray, self.headerTitle, self.errorMessage)
            }
        }
        
        dataTask?.resume()
        
    }
    
    func createFactsArray(_ data: Data) {
        
        //Remove all objects always
        factsArray.removeAll()
        
        let jsonString = NSString(data:data, encoding: String.Encoding.isoLatin1.rawValue)
        
        if let dataFromString = jsonString?.data(using: String.Encoding.utf8.rawValue) {
            do{
                let json = try JSON(data: dataFromString)
                
                headerTitle = json[POCConstants.POCKeys.POCHeaderTitle].stringValue
                
                guard let array = json[POCConstants.POCKeys.POCArray].arrayObject else{
                    return
                }
                for factsDictionary in array {
                    if let factsDictionary = factsDictionary as? JSONDictinary,
                        let title = factsDictionary[POCConstants.POCKeys.POCTitle] as? String{
                        
                        factsArray.append(POCFacts(title: title, imageHref: factsDictionary[POCConstants.POCKeys.POCImage] as? String, description: factsDictionary[POCConstants.POCKeys.POCDescription] as? String))
                        
                    }
                }
            }
            catch let parseError as NSError {
                errorMessage += "Error while parsing Json: \(parseError.localizedDescription)\n"
                return
            }
            
            
        }
    }
}
