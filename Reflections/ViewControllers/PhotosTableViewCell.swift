//
//  PhotosTableViewCell.swift
//  Reflections
//
//  Created by Rohit SIngh Dhakad on 29/06/24.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPurpose: UILabel!
    @IBOutlet weak var imgvwOne: UIImageView!
    @IBOutlet weak var vwPercentageOne: UIView!
    @IBOutlet weak var lblPercentageOne: UILabel!
    @IBOutlet weak var imgVwTwo: UIImageView!
    @IBOutlet weak var vwPercentageTwo: UIView!
    @IBOutlet weak var lblPercentageTwo: UILabel!
    @IBOutlet weak var imgVwThree: UIImageView!
    @IBOutlet weak var vwPercentageThree: UIView!
    @IBOutlet weak var lblPercentageThree: UILabel!
    @IBOutlet weak var imgVwFour: UIImageView!
    @IBOutlet weak var vwPerctageFour: UIView!
    @IBOutlet weak var lblPercentageFour: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
