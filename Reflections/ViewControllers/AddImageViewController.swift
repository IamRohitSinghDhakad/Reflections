//
//  AddImageViewController.swift
//  Reflections
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 02/07/24.
//

import UIKit
import iOSDropDown

class AddImageViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var tfPurpose: DropDown!
    
    var arrPurposeModel = [PurposeModel]()
    var imagePicker = UIImagePickerController()
    var pickedImage : UIImage?
    var addImageNumber = 1
    var arrImages = [UIImage]()
    var strSelectedpurposeId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.tfPurpose.delegate = self
        self.tfPurpose.didSelect { selectedText, index, id in
            self.tfPurpose.text = selectedText
            self.strSelectedpurposeId = "\(id)"
        }
        self.call_GetPuposes_Api()
    }

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    
    @IBAction func btnAddImageOne(_ sender: Any) {
        setImage()
        addImageNumber = 1
    }
    
    @IBAction func btnAddImageTwo(_ sender: Any) {
        setImage()
        addImageNumber = 2
    }
    
    @IBAction func btnAddImageThree(_ sender: Any) {
        setImage()
        addImageNumber = 3
    }
    
    @IBAction func btnAddImageFour(_ sender: Any) {
        setImage()
        addImageNumber = 4
       
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        if self.arrImages.count < 2{
            objAlert.showAlert(message: "Please select at least 2 images", controller: self)
        }else{
            if self.strSelectedpurposeId == ""{
                objAlert.showAlert(message: "Please select purpose", controller: self)
            }else{
                self.callWebserviceForUpdateImages()
            }
        }
    }
    
}

// MARK:- UIImage Picker Delegate
extension AddImageViewController: UIImagePickerControllerDelegate{
    
    func setImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    // Open camera
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.modalPresentationStyle = .fullScreen
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            self.openGallery()
        }
    }
    
    // Open gallery
    func openGallery()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickedImage = editedImage
            switch addImageNumber {
            case 1:
                self.imgOne.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            case 2:
                self.imgTwo.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            case 3:
                self.imgThree.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            default:
                self.imgFour.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            }
            
            imagePicker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.pickedImage = originalImage
            switch addImageNumber {
            case 1:
                self.imgOne.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            case 2:
                self.imgTwo.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            case 3:
                self.imgThree.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            default:
                self.imgFour.image = self.pickedImage
                self.arrImages.append(self.pickedImage!)
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func cornerImage(image: UIImageView, color: UIColor ,width: CGFloat){
        image.layer.cornerRadius = image.layer.frame.size.height / 2
        image.layer.masksToBounds = false
        image.layer.borderColor = color.cgColor
        image.layer.borderWidth = width
        
    }
    
//    func validateInputs() -> Bool {
//        guard let fullName = tffullName.text, !fullName.isEmpty else {
//            objAlert.showAlert(message: "Full name is required", title: "Alert", controller: self)
//            return false
//        }
//        
//        guard let price = tfPrice.text, !price.isEmpty else {
//            objAlert.showAlert(message: "Price is required", title: "Alert", controller: self)
//            return false
//        }
//        
//        guard let dateAndTime = tfDateandTime.text, !dateAndTime.isEmpty else {
//            objAlert.showAlert(message: "Date and time are required", title: "Alert", controller: self)
//            return false
//        }
//        
//        return true
//    }
    
}


extension AddImageViewController{
    
    func call_GetPuposes_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
                
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetPurposes, queryParams: [:], params: [:], strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    var arrOptions = [String]()
                    var arrOptionsID = [Int]()
                    for data in user_details{
                        let obj = PurposeModel(from: data)
                        arrOptions.append(obj.name ?? "")
                        arrOptionsID.append(Int(obj.purpose_id ?? "0") ?? 0)
                        self.arrPurposeModel.append(obj)
                    }
                    
                    self.tfPurpose.optionArray = arrOptions
                    self.tfPurpose.optionIds = arrOptionsID
                    
                    self.tfPurpose.reloadInputViews()
                    
                }
            }else{
                objWebServiceManager.hideIndicator()
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    func callWebserviceForUpdateImages(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
//        var imageData = [Data]()
//        var imgData : Data?
//
//        if self.pickedImage != nil{
//            imgData = (self.pickedImage?.jpegData(compressionQuality: 0.5))!
//        }
//        else {
//            imgData = (self.imgVwUser.image?.jpegData(compressionQuality: 0.5))!
//        }
//        imageData.append(imgData!)
        
        var imageDataArray = [Data]()
        var imageParam = [String]()

               for image in arrImages {
                   if let imgData = image.jpegData(compressionQuality: 0.5) {
                       imageDataArray.append(imgData)
                       imageParam.append("images[]")
                   }
               }
        print(imageDataArray)
        print(imageParam)
       
        
        let dicrParam = [
            "user_id":objAppShareData.UserDetail.strUserId ?? "",
            "purpose_id":strSelectedpurposeId]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_AddUserImage, params: dicrParam, showIndicator: true, customValidation: "", imageData: nil, imageToUpload: imageDataArray, imagesParam: imageParam, fileName: "images[]", mimeType: "images/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
                
                objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success!", message: "Album Image uploaded successfully", controller: self) {
                    self.onBackPressed()
                }
                
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
}
