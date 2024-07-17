//
//  WebViewController.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 17/07/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webVw: WKWebView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var isComingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.text = self.isComingFrom
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
}
