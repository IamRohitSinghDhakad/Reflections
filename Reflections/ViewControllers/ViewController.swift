//
//  ViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 29/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var counter = 1
    var timer:Timer?
    @IBOutlet var subVw: UIView!
    @IBOutlet weak var btnEmail: UIButton!
    
    var userDetail = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
        }else{
            self.timer?.invalidate()
            //  goToNextController()
            call_SignUp_Api()
            
        }
    }
    @IBAction func btnEmail(_ sender: Any) {
        self.addSubview(isAdd: false)
        objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: self.userDetail)
        objAppShareData.fetchUserInfoFromAppshareData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
        
    }
    
    @IBAction func btnAnotherAccount(_ sender: Any) {
        self.addSubview(isAdd: false)
        UserDefaults.standard.removeObject(forKey: UserDefaults.KeysDefault.userInfo)
        objAppShareData.UserDetail = UserModel(from: [:])
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer?.invalidate()
    }
    
    //MARK: - Redirection Methods
    //MARK: - Redirection Methods
    func goToNextController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if AppSharedData.sharedObject().isLoggedIn {
            let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navController
        }
        else {
            let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navController
        }
    }
    
    func call_SignUp_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        
        print("DeviceID ----->>", UIDevice.current.identifierForVendor!.uuidString
        )
        let dicrParam = ["device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "device_type":"iOS",
                         "device_token":objAppShareData.strFirebaseToken]as [String:Any]
        
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_SignUp, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    self.userDetail = user_details
                    if user_details["email"]as! String != "" && user_details["password"]as! String != "" && user_details["email_verified"]as! String != "" {
                        let email = user_details["email"]as! String
                        self.btnEmail.setTitle(email, for: .normal)
                        self.addSubview(isAdd: true)
                    }else{
                        objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: self.userDetail)
                        objAppShareData.fetchUserInfoFromAppshareData()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
                        let navController = UINavigationController(rootViewController: vc)
                        navController.isNavigationBarHidden = true
                        appDelegate.window?.rootViewController = navController
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
    
    
    func addSubview(isAdd: Bool) {
        if isAdd {
            self.subVw.frame = CGRect(x: 0, y: -(self.view.frame.height), width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(subVw)
            
            UIView.animate(withDuration: 0.3) {
                self.subVw.frame.origin.y = 0
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.subVw.frame.origin.y = self.view.frame.height
            } completion: { y in
                self.subVw.removeFromSuperview()
            }
        }
    }
    
}

