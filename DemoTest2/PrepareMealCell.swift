//
//  PrepareMealCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/26.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class PrepareMealCell: UITableViewCell {

 
    @IBOutlet weak var MealPic: UIImageView!
    @IBOutlet weak var MealPriceOrder: UILabel!
    @IBOutlet weak var MealCountInOrder: UILabel!
    @IBOutlet weak var MealNameInOrder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
