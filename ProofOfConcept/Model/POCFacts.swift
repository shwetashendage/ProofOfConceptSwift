//
//  Facts.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

class POCFacts{
    
    let title : String
    let imageHref : String?
    let description : String?
    
    init(title : String, imageHref:String?, description:String?) {
        
        self.title = title
        
        if let imageHref = imageHref{
            self.imageHref = imageHref
        }
        else{
            self.imageHref = POCConstants.POCNoImage
            
        }
        
        if let description = description{
            self.description = description
        }
        else{
            self.description = ""
        }
    }
}
