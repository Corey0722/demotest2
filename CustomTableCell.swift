//
//  CustomTableCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/7/17.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {

    @IBOutlet weak var MealPic: UIImageView!
//    @IBOutlet weak var MealPic: UIImageView!
    @IBOutlet weak var MealPrice: UILabel!
//    @IBOutlet weak var MealPic: UIView!
    @IBOutlet weak var MealID: UILabel!
//    @IBOutlet weak var MealID: UILabel!
//    @IBOutlet weak var MealPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    @IBOutlet weak var buttonmore: UIButton!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
