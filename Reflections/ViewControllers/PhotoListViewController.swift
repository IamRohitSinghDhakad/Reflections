//
//  PhotoListViewController.swift
//  Reflections
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 02/07/24.
//

import UIKit
import Swift

class PhotoListViewController: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var vwPendingBar: UIView!
    @IBOutlet weak var vwApprovedBar: UIView!
    @IBOutlet weak var lblPendingPhoto: UILabel!
    @IBOutlet weak var lblApprovedPhoto: UILabel!
    @IBOutlet weak var btnApprovedPhoto: UIButton!
    
    var arrHomeModel = [HomeModel]()
    var strStatusis = "Pending"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwImage.isHidden = true
        let nib = UINib(nibName: "PhotoListTableViewCell", bundle: nil)
        self.tblList.register(nib, forCellReuseIdentifier: "PhotoListTableViewCell")
        
        self.vwPendingBar.backgroundColor = UIColor(named: "blue")
        self.lblPendingPhoto.textColor = UIColor(named: "blue")
        
        self.vwApprovedBar.backgroundColor = UIColor.darkGray
        self.lblApprovedPhoto.textColor = UIColor.darkGray
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call_GetUserImages_Api(status: strStatusis)
    }
    
    @IBAction func btnCloseVw(_ sender: Any) {
        self.vwImage.isHidden = true
    }
    
    @IBAction func btnAddImage(_ sender: Any) {
        pushVc(viewConterlerId: "AddImageViewController")
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnPendingPhoto(_ sender: Any) {
        self.vwPendingBar.backgroundColor = UIColor(named: "blue")
        self.lblPendingPhoto.textColor = UIColor(named: "blue")
        
        self.vwApprovedBar.backgroundColor = UIColor.darkGray
        self.lblApprovedPhoto.textColor = UIColor.darkGray
        strStatusis = "Pending"
        self.call_GetUserImages_Api(status: strStatusis)
    }
    
    @IBAction func btnOnApprovedPhoto(_ sender: Any) {
        self.vwApprovedBar.backgroundColor = UIColor(named: "blue")
        self.lblApprovedPhoto.textColor = UIColor(named: "blue")
        
        self.vwPendingBar.backgroundColor = UIColor.darkGray
        self.lblPendingPhoto.textColor = UIColor.darkGray
        strStatusis = "Approved"
        self.call_GetUserImages_Api(status: strStatusis)
    }
    
}

extension PhotoListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHomeModel.count
    }
    /***
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoListTableViewCell", for: indexPath)as! PhotoListTableViewCell
        
        let obj = self.arrHomeModel[indexPath.row]
        
        cell.lblPurpose.text = obj.purpose_name
        
        
        let numberofImages = obj.total_images
        if numberofImages == "2"{
            
            cell.imgone.image = UIImage.init(named: "image")
            cell.imgTwo.image = UIImage.init(named: "image")
            cell.imgThree.image = UIImage.init(named: "image")
            cell.imgFour.image = UIImage.init(named: "image")
            
            let imageUrl  = obj.arrImages[0].imageUrl
            if imageUrl != "" {
                let url = URL(string: imageUrl)
                cell.imgone.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgone.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
            
            let imageUrl2  = obj.arrImages[1].imageUrl
            if imageUrl2 != "" {
                let url = URL(string: imageUrl2)
                cell.imgTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgTwo.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
            
            if obj.status == "Pending"{
                cell.vwPercentageOne.isHidden = true
                cell.vwPercentageTwo.isHidden = true
                cell.vwPercentageThree.isHidden = true
                cell.vwPercentageFour.isHidden = true
            }else{
                cell.vwPercentageOne.isHidden = false
                cell.vwPercentageTwo.isHidden = false
                cell.vwPercentageThree.isHidden = true
                cell.vwPercentageFour.isHidden = true
            }
            
        }else if numberofImages == "3"{
            
            cell.imgone.image = UIImage.init(named: "image")
            cell.imgTwo.image = UIImage.init(named: "image")
            cell.imgThree.image = UIImage.init(named: "image")
            cell.imgFour.image = UIImage.init(named: "image")
            
            let imageUrl  = obj.arrImages[0].imageUrl
            if imageUrl != "" {
                let url = URL(string: imageUrl)
                cell.imgone.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgone.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
            
            let imageUrl2  = obj.arrImages[1].imageUrl
            if imageUrl2 != "" {
                let url = URL(string: imageUrl2)
                cell.imgTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgTwo.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
            
            let imageUrl3  = obj.arrImages[2].imageUrl
            if imageUrl3 != "" {
                let url = URL(string: imageUrl3)
                cell.imgThree.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgThree.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageThree.text = "\(obj.arrImages[2].perecentage ?? "0")%"
            
            if obj.status == "Pending"{
                cell.vwPercentageOne.isHidden = true
                cell.vwPercentageTwo.isHidden = true
                cell.vwPercentageThree.isHidden = true
                cell.vwPercentageFour.isHidden = true
            }else{
                cell.vwPercentageOne.isHidden = false
                cell.vwPercentageTwo.isHidden = false
                cell.vwPercentageThree.isHidden = false
                cell.vwPercentageFour.isHidden = true
            }
            
        }else{
            
            cell.imgone.image = UIImage.init(named: "image")
            cell.imgTwo.image = UIImage.init(named: "image")
            cell.imgThree.image = UIImage.init(named: "image")
            cell.imgFour.image = UIImage.init(named: "image")
            
            let imageUrl  = obj.arrImages[0].imageUrl
            if imageUrl != "" {
                let url = URL(string: imageUrl)
                cell.imgone.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgone.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
            
            let imageUrl2  = obj.arrImages[1].imageUrl
            if imageUrl2 != "" {
                let url = URL(string: imageUrl2)
                cell.imgTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgTwo.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
            
            let imageUrl3  = obj.arrImages[2].imageUrl
            if imageUrl3 != "" {
                let url = URL(string: imageUrl3)
                cell.imgThree.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgThree.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageThree.text = "\(obj.arrImages[2].perecentage ?? "0")%"
            
            let imageUrl4  = obj.arrImages[3].imageUrl
            if imageUrl4 != "" {
                let url = URL(string: imageUrl4)
                cell.imgFour.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
            }else{
                cell.imgFour.image = #imageLiteral(resourceName: "launcher_200")
            }
            cell.lblPercentageFour.text = "\(obj.arrImages[3].perecentage ?? "0")%"
            
            if obj.status == "Pending"{
                cell.vwPercentageOne.isHidden = true
                cell.vwPercentageTwo.isHidden = true
                cell.vwPercentageThree.isHidden = true
                cell.vwPercentageFour.isHidden = true
            }else{
                cell.vwPercentageOne.isHidden = false
                cell.vwPercentageTwo.isHidden = false
                cell.vwPercentageThree.isHidden = false
                cell.vwPercentageFour.isHidden = false
            }
        }
        
        
        
        
        cell.btnOne.tag = indexPath.row
        cell.btntwo.tag = indexPath.row
        cell.btnThre.tag = indexPath.row
        cell.btnFour.tag = indexPath.row
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.delaysTouchesEnded = true
        longPress.minimumPressDuration = 1
        
        tapGesture.numberOfTapsRequired = 2
        cell.btnOne.addGestureRecognizer(tapGesture)
        cell.btntwo.addGestureRecognizer(tapGesture)
        cell.btnThre.addGestureRecognizer(tapGesture)
        cell.btnFour.addGestureRecognizer(tapGesture)
        cell.btnOne.addGestureRecognizer(longPress)
        cell.btntwo.addGestureRecognizer(longPress)
        cell.btnThre.addGestureRecognizer(longPress)
        cell.btnFour.addGestureRecognizer(longPress)
        
        return cell
    }
    
    @objc func tap() {
        
        print("Tap happend")
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended{
            print("Long press")
            self.vwImage.isHidden = false
        }
        
    }
    
    @objc func btnOne(sender: UIButton){
        
    }
     */
}
extension PhotoListViewController{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoListTableViewCell", for: indexPath) as! PhotoListTableViewCell
        
        let obj = self.arrHomeModel[indexPath.row]
        
        cell.lblPurpose.text = obj.purpose_name
        
        let numberofImages = obj.total_images ?? "0"
        configureCell(cell, with: obj, numberOfImages: numberofImages)
        
        cell.btnDelete.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteAlbum(sender: )), for: .touchUpInside)
        
        cell.btnOne.tag = (indexPath.row * 10) + 1
        cell.btntwo.tag = (indexPath.row * 10) + 2
        cell.btnThre.tag = (indexPath.row * 10) + 3
        cell.btnFour.tag = (indexPath.row * 10) + 4
        
        addGestureRecognizers(to: cell.btnOne)
        addGestureRecognizers(to: cell.btntwo)
        addGestureRecognizers(to: cell.btnThre)
        addGestureRecognizers(to: cell.btnFour)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")as! DetailViewController
        vc.arrImages = self.arrHomeModel[indexPath.row].arrImages
        vc.strPurposeName = self.arrHomeModel[indexPath.row].purpose_name ?? ""
        vc.isCOmingFrom = self.strStatusis
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnDeleteAlbum(sender: UIButton){
        
        print(sender.tag)
        objAlert.showAlertCallBack(alertLeftBtn: "Yes", alertRightBtn: "No", title: "Alert!", message: "Are you sure you want to delete this album ?", controller: self) {
            let obj = self.arrHomeModel[sender.tag].album_no
            self.call_deleteAlbum_Api(strAlbumNumber: obj ?? "")
        }
        
        
    }

    
    func configureCell(_ cell: PhotoListTableViewCell, with obj: HomeModel, numberOfImages: String) {
        let placeholders = ["logo", "launcher_200"]
        
        for (index, imageView) in [cell.imgone, cell.imgTwo, cell.imgThree, cell.imgFour].enumerated() {
            if index < obj.arrImages.count {
                let imageUrl = obj.arrImages[index].imageUrl
                let url = URL(string: imageUrl)
                imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: placeholders[index % placeholders.count]))
            } else {
                imageView?.image = #imageLiteral(resourceName: "image")
            }
        }
        
        cell.lblPercentageOne.text = "\(obj.arrImages[safe: 0]?.perecentage ?? "0")%"
        cell.lblPercentageTwo.text = "\(obj.arrImages[safe: 1]?.perecentage ?? "0")%"
        cell.lblPercentageThree.text = "\(obj.arrImages[safe: 2]?.perecentage ?? "0")%"
        cell.lblPercentageFour.text = "\(obj.arrImages[safe: 3]?.perecentage ?? "0")%"
        
        cell.vwPercentageThree.isHidden = obj.arrImages.count < 3
        cell.vwPercentageFour.isHidden = obj.arrImages.count < 4
    }

    
    
    func addGestureRecognizers(to button: UIButton) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        button.addGestureRecognizer(tapGesture)
        button.isUserInteractionEnabled = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        longPressGesture.delaysTouchesEnded = true
        longPressGesture.minimumPressDuration = 1
        button.addGestureRecognizer(longPressGesture)
        button.isUserInteractionEnabled = true
        
        button.isEnabled = isImageUrlAvailable(for: button.tag / 10, buttonIndex: button.tag % 10)
    }



    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let button = gesture.view as? UIButton else { return }
        let tag = button.tag
        let row = tag / 10
        let buttonIndex = tag % 10
        print("Tap happened on button \(buttonIndex) in row \(row)")
        
        if isImageUrlAvailable(for: row, buttonIndex: buttonIndex) {
            showImage(for: row, buttonIndex: buttonIndex)
            // Handle other tap actions if needed
        }
    }

    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            guard let button = gesture.view as? UIButton else { return }
            let tag = button.tag
            let row = tag / 10
            let buttonIndex = tag % 10
            print("Long press on button \(buttonIndex) in row \(row)")
            
            if isImageUrlAvailable(for: row, buttonIndex: buttonIndex) {
                showImage(for: row, buttonIndex: buttonIndex)
                self.vwImage.isHidden = false
                // Handle other long press actions if needed
            }
        }
    }
    
    func isImageUrlAvailable(for row: Int, buttonIndex: Int) -> Bool {
        let obj = self.arrHomeModel[row]
        guard buttonIndex - 1 < obj.arrImages.count else {
            print("No image available for this button index")
            return false
        }
        
        let imageUrlString = obj.arrImages[buttonIndex - 1].imageUrl
        return !imageUrlString.isEmpty
    }


    
    func showImage(for row: Int, buttonIndex: Int) {
        let obj = self.arrHomeModel[row]
        guard buttonIndex - 1 < obj.arrImages.count else {
            print("No image available for this button index")
            return
        }
        
        let imageUrlString = obj.arrImages[buttonIndex - 1].imageUrl
        if let imageUrl = URL(string: imageUrlString) {
            self.imgVw.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            self.imgVw.image = UIImage(named: "placeholder")
        }
    }

    
}

extension PhotoListViewController {
    
    func call_GetUserImages_Api(status:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id": objAppShareData.UserDetail.strUserId ?? "",
                         "status":status]as [String:Any]
                
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetUserImages, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    self.arrHomeModel.removeAll()
                    for data in user_details{
                        let obj = HomeModel(from: data)
                        self.arrHomeModel.append(obj)
                    }
                    
                    self.tblList.displayBackgroundText(text: "")
                    self.tblList.reloadData()
                }
            }else{
                objWebServiceManager.hideIndicator()
                self.arrHomeModel.removeAll()
                self.tblList.displayBackgroundText(text: "No Data Found")
                self.tblList.reloadData()
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    func call_deleteAlbum_Api(strAlbumNumber:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["album_no": strAlbumNumber]as [String:Any]
        
        print(dicrParam)
                
        objWebServiceManager.requestPost(strURL: WsUrl.url_deleteAlbum, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
        
                    self.call_GetUserImages_Api(status: self.strStatusis)

            }else{
                objWebServiceManager.hideIndicator()
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}
