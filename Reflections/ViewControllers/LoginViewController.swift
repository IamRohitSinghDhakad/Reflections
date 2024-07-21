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
    @IBOutlet weak var imgVwCheck: UIImageView!
    @IBOutlet weak var vwDontHaveaccount: UIView!
    @IBOutlet weak var vwResendLink: UIView!
    
    var isProfileExist = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwPassword.isHidden = true
        self.vwForgotPassword.isHidden = true
        self.vwPolicy.isHidden = true
        self.vwDontHaveaccount.isHidden = true
        self.vwResendLink.isHidden = true
    }
    @IBAction func btnResendLink(_ sender: Any) {
        self.call_CheckProfile_Api(status: "1")
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        self.pushVc(viewConterlerId: "ForgotPssswordViewController")
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")as! WebViewController
        vc.isComingFrom = "Privacy Policy"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnTermsAndService(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")as! WebViewController
        vc.isComingFrom = "Terms and Services"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAcceptReject(_ sender: Any) {
        imgVwCheck.image = UIImage(systemName: "checkmark.square")
    }
    
    @IBAction func btnOnSignUp(_ sender: Any) {
        self.vwForgotPassword.isHidden = false
        self.vwPassword.isHidden = false
        self.vwForgotPassword.isHidden = false
        self.vwPolicy.isHidden = false
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        
        if self.tfEmail.text == ""{
            objAlert.showAlert(message: "Please enter email first", controller: self)
        }else if isValidEmail(self.tfEmail.text!) == false{
            objAlert.showAlert(message: "Please enter valid email", controller: self)
        }else {
            if self.isProfileExist == 0{
                self.call_CheckProfile_Api(status: "0")
            }else if self.isProfileExist == 1{
                if self.tfPassword.text == ""{
                    objAlert.showAlert(message: "Please enter password first", controller: self)
                }else if isValidPassword(self.tfPassword.text!) == false{
                    objAlert.showAlert(message: "Password must be at least 6 characters", controller: self)
                }else{
                    self.call_SignUp_Api()
                }
                
            }else{
                if self.tfPassword.text == ""{
                    objAlert.showAlert(message: "Please enter password first", controller: self)
                }else if isValidPassword(self.tfPassword.text!) == false{
                    objAlert.showAlert(message: "Password must be at least 6 characters", controller: self)
                }else{
                    self.call_Login_Api()
                }
                
            }
        }
        
    }
    
    
    
    func isValidEmail(_ email: String) -> Bool {
            // Regular expression for validating an email
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }

        func isValidPassword(_ password: String) -> Bool {
            return password.count >= 6
        }
    
    func call_CheckProfile_Api(status: String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        print("DeviceID ----->>", UIDevice.current.identifierForVendor!.uuidString
        )
        let dicrParam = ["email": self.tfEmail.text!,
                         "status":status]as [String:Any]
       
        objWebServiceManager.requestPost(strURL: WsUrl.url_CheckProfile, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? String {
                    
                    if user_details == "User exist"{
                        self.vwForgotPassword.isHidden = false
                        self.vwPassword.isHidden = false
                        self.vwForgotPassword.isHidden = false
                        self.vwPolicy.isHidden = false
                        
                        self.isProfileExist = 2
                    }else{
                        
                    }
                }
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: "Email is not registered please sign up!", controller: self)
                self.vwDontHaveaccount.isHidden = false
                self.isProfileExist = 1
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    func call_SignUp_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        if self.imgVwCheck.image == UIImage(systemName: "checkmark.square"){
            
        }
        else{
            objAlert.showAlert(message: "Please read and accept the tearms and condition first", controller: self)
            return
        }
        print("DeviceID ----->>", UIDevice.current.identifierForVendor!.uuidString
        )
        let dicrParam = ["email": self.tfEmail.text!,
                         "password":self.tfPassword.text!,
                         "device_id":UIDevice.current.identifierForVendor!.uuidString]as [String:Any]
        objWebServiceManager.showIndicator()
        objWebServiceManager.requestPost(strURL: WsUrl.url_SignUp, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    self.vwResendLink.isHidden = false
                    self.call_CheckProfile_Api(status: "1")
                }
            }else{
                objWebServiceManager.hideIndicator()
                
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    func call_Login_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        if self.imgVwCheck.image == UIImage(systemName: "checkmark.square"){
            
        }
        else{
            objAlert.showAlert(message: "Please read and accept the tearms and condition first", controller: self)
            objWebServiceManager.hideIndicator()
            return
        }
        
        print("DeviceID ----->>", UIDevice.current.identifierForVendor!.uuidString
        )
        let dicrParam = ["email": self.tfEmail.text!,
                         "password":self.tfPassword.text!]as [String:Any]
        
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_Login, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                    if user_details["email_verified"] as! String == "1"{
                        objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                        objAppShareData.fetchUserInfoFromAppshareData()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
                        let navController = UINavigationController(rootViewController: vc)
                        navController.isNavigationBarHidden = true
                        appDelegate.window?.rootViewController = navController
                    }else{
                        objAlert.showAlert(message: "Please verify your account first", controller: self)
                    }
                    
                    
                    
                }
            }else{
                objWebServiceManager.hideIndicator()
                
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}
