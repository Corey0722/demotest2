//
//  MealCartCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/23.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class MealCartCell: UITableViewCell {


    @IBOutlet weak var MealPic: UIImageView!
    @IBOutlet weak var MealCount: UILabel!
    @IBOutlet weak var MealPrice: UILabel!
    @IBOutlet weak var MealName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
