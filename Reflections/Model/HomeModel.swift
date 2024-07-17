//
//  HomeModel.swift
//  GMS
//
//  Created by Rohit SIngh Dhakad on 17/11/23.
//

import UIKit

class HomeModel: NSObject {
    
    var total_votes: String?
    var total_images : String?
    var purpose_name: String?
    var status : String?
    var user_id : String?
    var album_no: String?
    var arrImages = [ImagesModel]()
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["user_id"] as? String {
            user_id = value
        }else if let value = dictionary["user_id"] as? Int {
            user_id = "\(value)"
        }
        
        if let value = dictionary["total_votes"] as? String {
            total_votes = value
        }else if let value = dictionary["total_votes"] as? Int {
            total_votes = "\(value)"
        }
        
        if let value = dictionary["total_images"] as? String {
            total_images = value
        }else if let value = dictionary["total_images"] as? Int {
            total_images = "\(value)"
        }
        
        //============//
        
        if let value = dictionary["status"] as? String {
            status = value
        }
        
        if let value = dictionary["purpose_name"] as? String {
            purpose_name = value
        }
        
        if let value = dictionary["album_no"] as? Int {
            album_no = "\(value)"
        }else if let value = dictionary["album_no"] as? String {
            album_no = value
        }
        
        if let arrImages = dictionary["images"]as? [[String: Any]]{
            for data in arrImages{
                let obj = ImagesModel(from: data)
                self.arrImages.append(obj)
            }
        }
    }
}

class ImagesModel: NSObject {
    
    var imageUrl = String()
    var image_id : String?
    var perecentage : String?
    var total_votes : String?
    var voted : String?
    var purposeName : String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["image_id"] as? String {
            image_id = value
        }else if let value = dictionary["image_id"] as? Int {
            image_id = "\(value)"
        }
        
        if let value = dictionary["perecentage"] as? String {
            perecentage = value
        }else if let value = dictionary["perecentage"] as? Int {
            perecentage = "\(value)"
        }
        
        if let value = dictionary["total_votes"] as? String {
            total_votes = value
        }else if let value = dictionary["total_votes"] as? Int {
            total_votes = "\(value)"
        }
        
        if let value = dictionary["voted"] as? String {
            voted = value
        }else if let value = dictionary["voted"] as? Int {
            voted = "\(value)"
        }
        
        if let value = dictionary["image"] as? String {
            imageUrl = value
        }
    }
}
