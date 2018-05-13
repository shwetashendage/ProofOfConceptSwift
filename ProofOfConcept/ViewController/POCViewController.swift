//
//  POCViewController.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit

class POCViewController: UITableViewController {
    let service = POCServiceClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "POC"
        
        //Call Service
        service.getResults()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

