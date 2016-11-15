//
//  MealCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/14.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var MealPic: UIImageView!
    
//    @IBOutlet weak var RevName: UILabel!
    
    @IBOutlet weak var MealFav: UISwitch!
    @IBOutlet weak var MealID: UILabel!
    @IBOutlet weak var MealPrice: UILabel!
//    var Rev_Name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    
}
