//
//  ApprovalDocument.swift
//  mNet
//
//  Created by Nachiket Vaidya on 21/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalDocument: NSObject, Mappable {
    
    /*"other_doc_link": "http://brandintell-hero.com/BrandIntell/UploadData/MR-17-18-0151/2017_May_Animatics_Pleasure_10-Yr-Anniversary_Research-Brief.docx",
     "other_doc_name": "2017_May_Animatics_Pleasure_10-Yr-Anniversary_Research-Brief.docx",
     "other_doc_type": "docx"*/
    
    var link:String = ""
    var name:String = ""
    var type:String = ""
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        link <- map["other_doc_link"]
        name <- map["other_doc_name"]
        type <- map["other_doc_type"]
        
    }
}
