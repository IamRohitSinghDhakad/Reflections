//
//  AddImageViewController.swift
//  Reflections
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 02/07/24.
//

import UIKit
import iOSDropDown

class AddImageViewController: UIViewController {

    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var tfPurpose: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    
    @IBAction func btnAddImageOne(_ sender: Any) {
        
    }
    
    @IBAction func btnAddImageTwo(_ sender: Any) {
        
    }
    
    @IBAction func btnAddImageThree(_ sender: Any) {
        
    }
    
    @IBAction func btnAddImageFour(_ sender: Any) {
        
    }
    
    
}
