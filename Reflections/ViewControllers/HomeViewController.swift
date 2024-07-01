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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PhotosTableViewCell", bundle: nil)
        self.tblVw.register(nib, forCellReuseIdentifier: "PhotosTableViewCell")
        
    }
    
    @IBAction func btnOnLogout(_ sender: Any) {
        
    }
    
    @IBAction func btnOnLoginAndHome(_ sender: Any) {
        
        
    }
    
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
        
        
        return cell
    }
    
}
