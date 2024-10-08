//
//  HomeViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 29/06/24.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imgVeHeaderButton: UIImageView!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var imgvwLogout: UIImageView!
    @IBOutlet weak var subVw: UIView!
    
    //SubVw
    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var vwPercentageOne: UIView!
    @IBOutlet weak var vwPercentageTwo: UIView!
    @IBOutlet weak var vwPercentageThree: UIView!
    @IBOutlet weak var vwPercentageFour: UIView!
    @IBOutlet weak var lblPercntageOne: UILabel!
    @IBOutlet weak var lblPercentagetwo: UILabel!
    @IBOutlet weak var lblPercentageThree: UILabel!
    @IBOutlet weak var lblPercentageFour: UILabel!
    @IBOutlet weak var imgVwBatchOne: UIImageView!
    @IBOutlet weak var imgVwBatchTwo: UIImageView!
    @IBOutlet weak var imgVwBatchThree: UIImageView!
    @IBOutlet weak var imgVwBatchFour: UIImageView!
    @IBOutlet weak var veBottom: UIView!
    @IBOutlet weak var vwThree: UIView!
    @IBOutlet weak var vwFour: UIView!
    
   
    
    var arrHomeModel = [HomeModel]()
    let refreshControl = UIRefreshControl()
    var indexpathForSubVw = -1
    var isComingFromVote = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwImage.isHidden = true
        self.subVw.isHidden = true
        // Do any additional setup after loading the view.
        //  call_GetPuposes_Api()
        let nib = UINib(nibName: "PhotosTableViewCell", bundle: nil)
        self.tblVw.register(nib, forCellReuseIdentifier: "PhotosTableViewCell")
        
        // Configure Refresh Control
        if #available(iOS 10.0, *) {
            self.tblVw.refreshControl = refreshControl
        } else {
            self.tblVw.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Update your data here
        self.call_GetUserImages_Api()
    }
    
    @IBAction func btnGotoSetting(_ sender: Any) {
        self.pushVc(viewConterlerId: "SettingViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isComingFromVote = false
        call_GetUserImages_Api()
        if objAppShareData.UserDetail.email == ""{
            self.imgvwLogout.isHidden = true
            self.imgVeHeaderButton.image = UIImage(named: "login")
        }else{
            self.imgvwLogout.isHidden = false
            self.imgVeHeaderButton.image = UIImage(named: "list")
        }
    }
    
    @IBAction func btnOnLogout(_ sender: Any) {
        objAlert.showAlertCallBack(alertLeftBtn: "Yes", alertRightBtn: "No", title: "Logout Alert", message: "Are you sure you want to logout?", controller: self) {
            objAppShareData.signOut()
        }
    }
    
    @IBAction func btnOnLoginAndHome(_ sender: Any) {
        if objAppShareData.UserDetail.email == ""{
            objAppShareData.signOut()
            // pushVc(viewConterlerId: "LoginViewController")
        }else{
            pushVc(viewConterlerId: "PhotoListViewController")
        }
        
        
    }
    
    @IBAction func btnCloseImageView(_ sender: Any) {
        self.vwImage.isHidden = true
    }
    
    @IBAction func btnOnOKSubVw(_ sender: Any) {
        self.subVw.isHidden = true
        isComingFromVote = false
    }
    @IBAction func btnOnCloseSubVw(_ sender: Any) {
        self.subVw.isHidden = true
        isComingFromVote = false
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHomeModel.count
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)as! PhotosTableViewCell
    //
    //
    //        let obj = self.arrHomeModel[indexPath.row]
    //
    //        cell.lblPurpose.text = obj.purpose_name
    //
    //        let numberofImages = obj.total_images
    //        if numberofImages == "2"{
    //
    //            let imageUrl  = obj.arrImages[0].imageUrl
    //            if imageUrl != "" {
    //                let url = URL(string: imageUrl)
    //                cell.imgvwOne.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgvwOne.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
    //
    //            let imageUrl2  = obj.arrImages[1].imageUrl
    //            if imageUrl2 != "" {
    //                let url = URL(string: imageUrl2)
    //                cell.imgVwTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgvwOne.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
    //
    //            cell.vwPercentageThree.isHidden = true
    //            cell.vwPerctageFour.isHidden = true
    //
    //        }else if numberofImages == "3"{
    //
    //            let imageUrl  = obj.arrImages[0].imageUrl
    //            if imageUrl != "" {
    //                let url = URL(string: imageUrl)
    //                cell.imgvwOne.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgvwOne.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
    //
    //            let imageUrl2  = obj.arrImages[1].imageUrl
    //            if imageUrl2 != "" {
    //                let url = URL(string: imageUrl2)
    //                cell.imgVwTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgVwTwo.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
    //
    //            let imageUrl3  = obj.arrImages[2].imageUrl
    //            if imageUrl3 != "" {
    //                let url = URL(string: imageUrl3)
    //                cell.imgVwThree.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgVwThree.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageThree.text = "\(obj.arrImages[2].perecentage ?? "0")%"
    //
    //            cell.vwPercentageThree.isHidden = false
    //            cell.vwPerctageFour.isHidden = true
    //
    //        }else{
    //
    //            let imageUrl  = obj.arrImages[0].imageUrl
    //            if imageUrl != "" {
    //                let url = URL(string: imageUrl)
    //                cell.imgvwOne.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgvwOne.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageOne.text = "\(obj.arrImages[0].perecentage ?? "0")%"
    //
    //            let imageUrl2  = obj.arrImages[1].imageUrl
    //            if imageUrl2 != "" {
    //                let url = URL(string: imageUrl2)
    //                cell.imgVwTwo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgvwOne.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageTwo.text = "\(obj.arrImages[1].perecentage ?? "0")%"
    //
    //            let imageUrl3  = obj.arrImages[2].imageUrl
    //            if imageUrl3 != "" {
    //                let url = URL(string: imageUrl3)
    //                cell.imgVwThree.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgVwThree.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageThree.text = "\(obj.arrImages[2].perecentage ?? "0")%"
    //
    //            let imageUrl4  = obj.arrImages[3].imageUrl
    //            if imageUrl4 != "" {
    //                let url = URL(string: imageUrl4)
    //                cell.imgVwFour.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
    //            }else{
    //                cell.imgVwFour.image = #imageLiteral(resourceName: "launcher_200")
    //            }
    //            cell.lblPercentageFour.text = "\(obj.arrImages[3].perecentage ?? "0")%"
    //
    //            cell.vwPercentageThree.isHidden = false
    //            cell.vwPerctageFour.isHidden = false
    //        }
    //
    //
    //        cell.btnOne.tag = indexPath.row
    //        cell.btnTwo.tag = indexPath.row
    //        cell.btnThree.tag = indexPath.row
    //        cell.btnFour.tag = indexPath.row
    //
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
    //        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
    //        longPress.delaysTouchesEnded = true
    //        longPress.minimumPressDuration = 1
    //
    //        tapGesture.numberOfTapsRequired = 2
    //        cell.btnOne.addGestureRecognizer(tapGesture)
    //        cell.btnTwo.addGestureRecognizer(tapGesture)
    //        cell.btnThree.addGestureRecognizer(tapGesture)
    //        cell.btnFour.addGestureRecognizer(tapGesture)
    //        cell.btnOne.addGestureRecognizer(longPress)
    //        cell.btnTwo.addGestureRecognizer(longPress)
    //        cell.btnThree.addGestureRecognizer(longPress)
    //        cell.btnFour.addGestureRecognizer(longPress)
    //
    //        return cell
    //    }
    
    //    @objc func tap() {
    //
    //        print("Tap happend")
    //    }
    //
    //    @objc func longPress(gesture: UILongPressGestureRecognizer) {
    //        if gesture.state == .ended{
    //            print("Long press")
    //            self.vwImage.isHidden = false
    //        }
    //
    //    }
    //
    //    @objc func btnOne(sender: UIButton){
    //
    //    }
}

extension HomeViewController{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        
        let obj = self.arrHomeModel[indexPath.row]
        
        cell.lblPurpose.text = obj.purpose_name
        
        let numberofImages = obj.total_images ?? "0"
        configureCell(cell, with: obj, numberOfImages: numberofImages)
        
        cell.btnOne.tag = (indexPath.row * 10) + 1
        cell.btnTwo.tag = (indexPath.row * 10) + 2
        cell.btnThree.tag = (indexPath.row * 10) + 3
        cell.btnFour.tag = (indexPath.row * 10) + 4
        
        addGestureRecognizers(to: cell.btnOne)
        addGestureRecognizers(to: cell.btnTwo)
        addGestureRecognizers(to: cell.btnThree)
        addGestureRecognizers(to: cell.btnFour)
        
        if obj.total_votes != "0"{
            cell.vwBackground.backgroundColor = UIColor(named: "light_blue")
        }else{
            cell.vwBackground.backgroundColor = UIColor(named: "blue")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")as! DetailViewController
        vc.arrImages = self.arrHomeModel[indexPath.row].arrImages
        vc.strPurposeName = self.arrHomeModel[indexPath.row].purpose_name ?? ""
        vc.obj = self.arrHomeModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCell(_ cell: PhotosTableViewCell, with obj: HomeModel, numberOfImages: String) {
        let placeholders = ["logo", "launcher_200"]
        
        // Check if any image has voted == 1
        let anyImageVoted = obj.arrImages.contains { $0.voted == "1" }
        
        for (index, imageView) in [cell.imgvwOne, cell.imgVwTwo, cell.imgVwThree, cell.imgVwFour].enumerated() {
            if index < obj.arrImages.count {
                let imageUrl = obj.arrImages[index].imageUrl
                let url = URL(string: imageUrl)
                imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: placeholders[index % placeholders.count]))
            } else {
                imageView?.image = #imageLiteral(resourceName: "image") // UIImage(named: "launcher_200")
            }
        }
        
        cell.lblPercentageOne.text = "\(obj.arrImages[safe: 0]?.perecentage ?? "0")%"
        cell.lblPercentageTwo.text = "\(obj.arrImages[safe: 1]?.perecentage ?? "0")%"
        cell.lblPercentageThree.text = "\(obj.arrImages[safe: 2]?.perecentage ?? "0")%"
        cell.lblPercentageFour.text = "\(obj.arrImages[safe: 3]?.perecentage ?? "0")%"
        
        // Reset the visibility of the batch image views
        cell.imgVwBatchOne.isHidden = true
        cell.imgVwBatchTwo.isHidden = true
        cell.imgVwBatchThree.isHidden = true
        cell.imgVwBatchFour.isHidden = true
        
        // Reset the visibility of the percentage views
        cell.vwPercentageOne.isHidden = true
        cell.vwPercentageTwo.isHidden = true
        cell.vwPercentageThree.isHidden = true
        cell.vwPerctageFour.isHidden = true
        
        // Set the visibility of the percentage views based on the condition
        if anyImageVoted {
            if obj.arrImages.count > 0 {
                cell.vwPercentageOne.isHidden = false
            }
            if obj.arrImages.count > 1 {
                cell.vwPercentageTwo.isHidden = false
            }
            if obj.arrImages.count > 2 {
                cell.vwPercentageThree.isHidden = false
            }
            if obj.arrImages.count > 3 {
                cell.vwPerctageFour.isHidden = false
            }
            
            // Find the index of the image with the highest percentage
            var highestPercentageIndex = 0
            for i in 1..<obj.arrImages.count {
                if let percentage = obj.arrImages[i].perecentage,
                   let highestPercentage = obj.arrImages[highestPercentageIndex].perecentage,
                   percentage > highestPercentage {
                    highestPercentageIndex = i
                }
            }
            
            // Show batch image view based on highest percentage index
            if highestPercentageIndex < obj.arrImages.count {
                switch highestPercentageIndex {
                case 0:
                    cell.imgVwBatchOne.isHidden = false
                case 1:
                    cell.imgVwBatchTwo.isHidden = false
                case 2:
                    cell.imgVwBatchThree.isHidden = false
                case 3:
                    cell.imgVwBatchFour.isHidden = false
                default:
                    break
                }
            }
        }
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
        indexpathForSubVw = row
        if arrHomeModel[row].arrImages.contains(where: { $0.voted == "1" }) {
            // At least one element has voted == "1"
        } else {
            if isImageUrlAvailable(for: row, buttonIndex: buttonIndex) {
                showImage(for: row, buttonIndex: buttonIndex)
                if objAppShareData.UserDetail.strUserId == arrHomeModel[row].user_id{
                    
                }else{
                    
                    self.call_VoteImage_Api(strImageId: self.arrHomeModel[row].arrImages[buttonIndex - 1].image_id ?? "")
                }
                
            }
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
    
    
    //SubVw Image Maintain
    
    func setImageForSubVw(obj: HomeModel){
        
        self.lblPurpose.text = obj.purpose_name
        
        self.imgOne.tag = 0
        self.imgTwo.tag = 1
        self.imgThree.tag = 2
        self.imgFour.tag = 3
        
        self.vwPercentageOne.isHidden = true
        self.vwPercentageTwo.isHidden = true
        self.vwPercentageThree.isHidden = true
        self.vwPercentageFour.isHidden = true
        self.imgVwBatchThree.isHidden = true
        self.imgVwBatchOne.isHidden = true
        self.imgVwBatchTwo.isHidden = true
        self.imgVwBatchFour.isHidden = true
        
        let imageViews = [imgOne, imgTwo, imgThree, imgFour]
        
        for (index, imageView) in imageViews.enumerated() {
            guard index < self.arrHomeModel[indexpathForSubVw].arrImages.count else {
                imageView?.isHidden = true
                continue
            }
            
            let imageUrlString = self.arrHomeModel[indexpathForSubVw].arrImages[index].imageUrl
            if let imageUrl = URL(string: imageUrlString), !imageUrlString.isEmpty {
                imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo"))
                imageView?.isHidden = false
            } else {
                imageView?.isHidden = true
            }
        }
        
        
        //==================== Percentage Set ====================//
        
        self.lblPercntageOne.text = "\(obj.arrImages[safe: 0]?.perecentage ?? "0")%"
        self.lblPercentagetwo.text = "\(obj.arrImages[safe: 1]?.perecentage ?? "0")%"
        self.lblPercentageThree.text = "\(obj.arrImages[safe: 2]?.perecentage ?? "0")%"
        self.lblPercentageFour.text = "\(obj.arrImages[safe: 3]?.perecentage ?? "0")%"
        
        // Check if any image has voted == 1
        let anyImageVoted = obj.arrImages.contains { $0.voted == "1" }
        // Set the visibility of the percentage views based on the condition
        if anyImageVoted {
            if obj.arrImages.count > 0 {
                self.vwPercentageOne.isHidden = false
            }
            if obj.arrImages.count > 1 {
                self.vwPercentageTwo.isHidden = false
            }
            if obj.arrImages.count > 2 {
                self.vwPercentageThree.isHidden = false
            }
            if obj.arrImages.count > 3 {
                self.vwPercentageFour.isHidden = false
            }
            
            // Find the index of the image with the highest percentage
            var highestPercentageIndex = 0
            for i in 1..<obj.arrImages.count {
                if let percentage = obj.arrImages[i].perecentage,
                   let highestPercentage = obj.arrImages[highestPercentageIndex].perecentage,
                   percentage > highestPercentage {
                    highestPercentageIndex = i
                }
            }
            
            // Show batch image view based on highest percentage index
            if highestPercentageIndex < obj.arrImages.count {
                switch highestPercentageIndex {
                case 0:
                    self.imgVwBatchOne.isHidden = false
                case 1:
                    self.imgVwBatchTwo.isHidden = false
                case 2:
                    self.imgVwBatchThree.isHidden = false
                case 3:
                    self.imgVwBatchFour.isHidden = false
                default:
                    break
                }
            }
        }
    }
    
    
}


extension HomeViewController {
    
    
    
    func call_GetUserImages_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["login_id": objAppShareData.UserDetail.strUserId ?? "",
                         "status":"Approved"]as [String:Any]
        
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
                    self.tblVw.displayBackgroundText(text: "")
                    // End refreshing
                    self.refreshControl.endRefreshing()
                    self.tblVw.reloadData()
                    
                    if self.isComingFromVote == true{
                        self.setImageForSubVw(obj: self.arrHomeModel[self.indexpathForSubVw])
                        self.subVw.isHidden = false
                    }else{
                        
                    }
                   
                }
            }else{
                self.refreshControl.endRefreshing()
                self.arrHomeModel.removeAll()
                self.tblVw.displayBackgroundText(text: "No Data Found")
                self.tblVw.reloadData()
                objWebServiceManager.hideIndicator()
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
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
                self.isComingFromVote = true
                self.call_GetUserImages_Api()
            }else{
                objWebServiceManager.hideIndicator()
                
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}


extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
