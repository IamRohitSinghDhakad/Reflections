//
//  PhotoListTableViewCell.swift
//  Reflections
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 02/07/24.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btntwo: UIButton!
    @IBOutlet weak var btnThre: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var imgone: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var vwPercentageOne: UIView!
    @IBOutlet weak var vwPercentageTwo: UIView!
    @IBOutlet weak var vwPercentageThree: UIView!
    @IBOutlet weak var vwPercentageFour: UIView!
    @IBOutlet weak var lblPercentageFour: UILabel!
    @IBOutlet weak var lblPercentageThree: UILabel!
    @IBOutlet weak var lblPercentageTwo: UILabel!
    @IBOutlet weak var lblPercentageOne: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
