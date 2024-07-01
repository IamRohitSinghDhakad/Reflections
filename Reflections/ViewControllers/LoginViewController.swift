//
//  LoginViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 29/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var vwForgotPassword: UIView!
    @IBOutlet weak var vwPolicy: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwPassword.isHidden = true
        self.vwForgotPassword.isHidden = true
        self.vwPolicy.isHidden = true
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
    }
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
    }
    
    @IBAction func btnTermsAndService(_ sender: Any) {
        
    }
    
    @IBAction func btnAcceptReject(_ sender: Any) {
        
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        self.vwPassword.isHidden = false
        self.vwForgotPassword.isHidden = false
        self.vwPolicy.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.pushVc(viewConterlerId: "HomeViewController")
        })
      
    }
}
