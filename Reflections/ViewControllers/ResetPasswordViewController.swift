//
//  ResetPasswordViewController.swift
//  SocialGame
//
//  Created by Rohit SIngh Dhakad on 18/02/24.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfNewPasswword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblOldPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    var strOldPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        call_getProfileAPI()
        setlanguage()
       
    }
    
    func setlanguage(){
        self.lblHeader.text = "Reset Password"
        self.lblOldPassword.text = "Old Password"
        self.lblNewPassword.text = "New Password"
        self.lblConfirmPassword.text = "Confirm Password"
        self.btnUpdate.setTitle("Update", for: .normal)
    }
    
    
    @IBAction func btnOnOldPassword(_ sender: Any) {
        self.tfOldPassword.isSecureTextEntry = self.tfOldPassword.isSecureTextEntry == true ? false : true
    }

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNewPassword(_ sender: Any) {
        self.tfNewPasswword.isSecureTextEntry = self.tfNewPasswword.isSecureTextEntry == true ? false : true
    }
    
    @IBAction func btnOnConfirmPassword(_ sender: Any) {
        self.tfConfirmPassword.isSecureTextEntry = self.tfConfirmPassword.isSecureTextEntry == true ? false : true
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        if validatePassword() {
            self.call_WsResetPassword()
        }
    }
    
    func validatePassword() -> Bool {
            guard let oldPassword = self.tfOldPassword.text, !oldPassword.isEmpty,
                  let newPassword = self.tfNewPasswword.text, !newPassword.isEmpty,
                  let confirmPassword = self.tfConfirmPassword.text, !confirmPassword.isEmpty else {
                objAlert.showAlert(message: "Please fill in all fields.", controller: self)
                return false
            }
            
            // Check if old password matches the stored old password
            if oldPassword != strOldPassword {
                objAlert.showAlert(message: "Old Password is incorrect.", controller: self)
                return false
            }
            
            // Check if new password and confirm password match
            if newPassword != confirmPassword {
                objAlert.showAlert(message: "New Password and Confirm Password do not match.", controller: self)
                return false
            }
            
            // Validate new password complexity
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            if !passwordPredicate.evaluate(with: newPassword) {
                objAlert.showAlert(message: "Password must be at least 8 characters long, include at least one uppercase letter, one lowercase letter, and one special character.", controller: self)
                return false
            }
            
            return true
        }

}


extension ResetPasswordViewController {
    
    func call_WsResetPassword(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        var dicrParam = [String:Any]()
        dicrParam = ["old_password":self.tfOldPassword.text!,
                     "new_password":self.tfNewPasswword.text!,
                     "user_id":objAppShareData.UserDetail.strUserId!
        ]
        print(dicrParam)
                     
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_ChangePassword, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: "Password reset successfully", controller: self) {
                        self.onBackPressed()
                    }
                    
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
                
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    func call_getProfileAPI(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        var dicrParam = [String:Any]()
        
        var url = ""
        dicrParam = ["user_id":objAppShareData.UserDetail.strUserId ?? ""]as [String:Any]
            
        url = WsUrl.url_getUserProfile
        
        print(dicrParam)
        
        
        
        objWebServiceManager.requestPost(strURL: url, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                let objUser = UserModel(from: user_details)
                
                    self.strOldPassword = objUser.password ?? ""
                    
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                 
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
                
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}
