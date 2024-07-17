//
//  QuestionModel.swift
//  Know
//
//  Created by Rohit SIngh Dhakad on 27/01/24.
//

import UIKit

class PurposeModel: NSObject {

    var name: String?
    var purpose_id: String?
  
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["purpose_id"] as? String {
            purpose_id = value
        }
        
        if let value = dictionary["name"] as? String {
            name = value
        }
     
    }

}
