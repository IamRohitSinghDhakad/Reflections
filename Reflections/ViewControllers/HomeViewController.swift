//
//  HomeViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 29/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imgVeHeaderButton: UIImageView!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwImage.isHidden = true
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PhotosTableViewCell", bundle: nil)
        self.tblVw.register(nib, forCellReuseIdentifier: "PhotosTableViewCell")
        
    }
    
    @IBAction func btnOnLogout(_ sender: Any) {
        
    }
    
    @IBAction func btnOnLoginAndHome(_ sender: Any) {
        pushVc(viewConterlerId: "PhotoListViewController")
        
    }
    
    @IBAction func btnCloseImageView(_ sender: Any) {
        self.vwImage.isHidden = true
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)as! PhotosTableViewCell
        
        
        cell.btnOne.tag = indexPath.row
        cell.btnTwo.tag = indexPath.row
        cell.btnThree.tag = indexPath.row
        cell.btnFour.tag = indexPath.row
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.delaysTouchesEnded = true
        longPress.minimumPressDuration = 1
        
        tapGesture.numberOfTapsRequired = 2
        cell.btnOne.addGestureRecognizer(tapGesture)
        cell.btnTwo.addGestureRecognizer(tapGesture)
        cell.btnThree.addGestureRecognizer(tapGesture)
        cell.btnFour.addGestureRecognizer(tapGesture)
        cell.btnOne.addGestureRecognizer(longPress)
        cell.btnTwo.addGestureRecognizer(longPress)
        cell.btnThree.addGestureRecognizer(longPress)
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
