//
//  ResCartCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/23.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ResCartCell: UITableViewCell {

   
 
 


    @IBOutlet weak var MealPic: UIImageView!
    @IBOutlet weak var StorePic: UIImageView!
    @IBOutlet weak var RemoveCart: UIButton!

    @IBOutlet weak var Guest_Count: UITextField!
    @IBOutlet weak var MealPrice: UILabel!
    @IBOutlet weak var MealID: UILabel!
    @IBOutlet weak var MealCount: UILabel!
    @IBOutlet weak var ResLoc: UILabel!
    @IBOutlet weak var ResTel: UILabel!
    @IBOutlet weak var ResName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
