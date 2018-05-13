//
//  POCViewController.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit

//Internet
import Reachability

class POCViewController: UITableViewController {
    
    let service = POCServiceClass()
    var factsArray: [POCFacts] = []
    let reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "POC"
        
        if reachability.connection == .none{
            
            self.showAlertWith(title: "Message", message: "No Internet connection.")
            
        }
        else{
            
            //Call Service
            service.getResults(completion: { results, headerTitle, errorMessage in
                
                //Update Header Title
                if !headerTitle.isEmpty {
                    self.title = headerTitle
                }
                
                //Create facts array
                if let results = results {
                    self.factsArray = results
                }
                
                //Check for Error Message
                if !errorMessage.isEmpty {
                    print("Error: " + errorMessage)
                    self.showAlertWith(title: "Message", message: "Error occurred")
                }
            })
            
        }
        
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

