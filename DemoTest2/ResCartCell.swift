//
//  ResCartCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/23.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class ResCartCell: UITableViewCell {

   
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
