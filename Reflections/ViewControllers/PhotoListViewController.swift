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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwImage.isHidden = true
        let nib = UINib(nibName: "PhotoListTableViewCell", bundle: nil)
        self.tblList.register(nib, forCellReuseIdentifier: "PhotoListTableViewCell")
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
    
}

extension PhotoListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoListTableViewCell", for: indexPath)as! PhotoListTableViewCell
        
        
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
}
