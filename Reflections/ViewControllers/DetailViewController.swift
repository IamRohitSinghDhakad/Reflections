//
//  DetailViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 17/07/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    
    var arrImages = [ImagesModel]()
    var strPurposeName = ""
    var isCOmingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwImage.isHidden = true
        self.addGestureRecognizers(to: imgOne)
        self.addGestureRecognizers(to: imgTwo)
        self.addGestureRecognizers(to: imgThree)
        self.addGestureRecognizers(to: imgFour)
        self.lblPurpose.text = "Purpose - \(strPurposeName)"
        setImages()
        
    }
    
    func setImages() {
        
        self.imgOne.tag = 0
        self.imgTwo.tag = 1
        self.imgThree.tag = 2
        self.imgFour.tag = 3
        
        let imageViews = [imgOne, imgTwo, imgThree, imgFour]
        
        for (index, imageView) in imageViews.enumerated() {
            guard index < arrImages.count else {
                imageView?.isHidden = true
                continue
            }
            
            let imageUrlString = arrImages[index].imageUrl
            if let imageUrl = URL(string: imageUrlString), !imageUrlString.isEmpty {
                imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo"))
                imageView?.isHidden = false
            } else {
                imageView?.isHidden = true
            }
        }
    }


    
    @IBAction func btnCloseVw(_ sender: Any) {
        self.vwImage.isHidden = true
    }
    
    func addGestureRecognizers(to imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        longPressGesture.delaysTouchesEnded = true
        longPressGesture.minimumPressDuration = 1
        imageView.addGestureRecognizer(longPressGesture)
        imageView.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
   
        if self.isCOmingFrom == "Pending" || self.isCOmingFrom == "pending"{
            
        }else{
            guard let imgVw = gesture.view as? UIImageView else { return }
            let tag = imgVw.tag
            print("Tap happened on imgVw \(tag)")
            
            if arrImages.contains(where: { $0.voted == "1" }) {
                // At least one element has voted == "1"
            } else {
                    self.call_VoteImage_Api(strImageId: arrImages[tag].image_id ?? "")
            }
        }
       
        
       
    }

    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                guard let imageView = gesture.view as? UIImageView else { return }
                let buttonIndex = imageView.tag
                print("Long press on image \(buttonIndex)")
                
                if isImageUrlAvailable(for: buttonIndex) {
                    showImage(for: buttonIndex)
                    self.vwImage.isHidden = false
                    // Handle other long press actions if needed
                }
            }
        }

    func isImageUrlAvailable(for buttonIndex: Int) -> Bool {
            guard buttonIndex < arrImages.count else {
                print("No image available for this button index")
                return false
            }
            
            let imageUrlString = arrImages[buttonIndex].imageUrl
            return !imageUrlString.isEmpty
        }
    
    func showImage(for buttonIndex: Int) {
        print(buttonIndex)
        let imageUrlString = self.arrImages[buttonIndex].imageUrl
        if let imageUrl = URL(string: imageUrlString) {
            self.imgVw.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo"))
        } else {
            self.imgVw.image = UIImage(named: "logo")
        }
        
        }

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    
    func call_VoteImage_Api(strImageId:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id": objAppShareData.UserDetail.strUserId ?? "",
                         "image_id":strImageId]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_VoteImage, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Voted Successfully", message: "Your vote has been submitted succesfully", controller: self) {
                    self.onBackPressed()
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


