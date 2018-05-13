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
    var spinnerActivity: MBProgressHUD?
    var cache : NSCache<AnyObject,AnyObject>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "POC"
        
        self.tableView.register(POCTableViewCell.self, forCellReuseIdentifier: "pocCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        self.tableView.separatorInset = .zero
        
        cache = NSCache()

        if reachability.connection == .none{
            
            self.showAlertWith(title: "Message", message: "No Internet connection.")
            
        }
        else{
            
            //Show Progress View
            self.showIndicator()
            
            //Call Service
            service.getResults(completion: { results, headerTitle, errorMessage in
                
                //Hide Progress View
                self.hideIndicator()
                
                //Update Header Title
                if !headerTitle.isEmpty {
                    self.title = headerTitle
                }
                
                //Create facts array
                if let results = results {
                    self.factsArray = results
                    self.tableView.reloadData()
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
    //MARK: MBProgressHUD
    func showIndicator() {
        
        DispatchQueue.main.async {
            
            // fetch data from server
            self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.spinnerActivity?.label.text = "Please Wait...";
            self.spinnerActivity?.isUserInteractionEnabled = true;
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.spinnerActivity?.hide(animated: true)
        }
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.factsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pocCell", for: indexPath) as! POCTableViewCell
        
        cell.titleLabel.text = self.factsArray[indexPath.row].title
        cell.descriptionLabel.text = self.factsArray[indexPath.row].description
        cell.imageProfile.image = #imageLiteral(resourceName: "default-user-image")
        if self.factsArray[indexPath.row].imageHref == POCConstants.POCNoImage{

        }else if self.cache.object(forKey: self.factsArray[indexPath.row].imageHref! as AnyObject) != nil{
            cell.imageProfile.image = (self.cache.object(forKey: self.factsArray[indexPath.row].imageHref! as AnyObject) as! UIImage)
        }
        else{
            

            service.getImageFromUrlString(urlString: self.factsArray[indexPath.row].imageHref!, completion: { image, error in
                
                //Check For Image
                if let thereIsImage = image{
                    
                    DispatchQueue.main.async{
                        if let updateCell = tableView.cellForRow(at: indexPath) as? POCTableViewCell{
                            
                            updateCell.imageProfile.image = thereIsImage
                            
                        }
                    }
                    
                    self.cache.setObject(thereIsImage, forKey: self.factsArray[indexPath.row].imageHref! as AnyObject)
                }
                //Check for Error Message
                if !error.isEmpty {
                }
                
                
            })
        }
        
        return cell
        
    }
    
}

