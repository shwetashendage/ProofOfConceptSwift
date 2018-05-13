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
    var factsArray : [Any] = []
    
    
    func getResults() {
        
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
        }
        
        dataTask?.resume()
        
    }
    
    func createFactsArray(_ data: Data) {
        
        
        let jsonString = NSString(data:data, encoding: String.Encoding.isoLatin1.rawValue)
        
        if let dataFromString = jsonString?.data(using: String.Encoding.utf8.rawValue) {
            do{
                let json = try JSON(data: dataFromString)
                print(json["title"])
                guard let array = json["rows"].arrayObject else{
                    return
                }
                print(array)
                factsArray = array
                
            }
            catch let parseError as NSError {
                errorMessage += "Error while parsing Json: \(parseError.localizedDescription)\n"
                return
            }
            
            
        }
    }
}
