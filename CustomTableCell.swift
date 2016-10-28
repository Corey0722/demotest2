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
    @IBOutlet weak var MealID: UILabel!
    @IBOutlet weak var MealPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    @IBOutlet weak var buttonmore: UIButton!

    @IBAction func buttommoreAdT(sender: AnyObject){

     
       meal.showMealInformation(<#T##meal#>)
        
        //製作點擊後顯示餐點資訊Controller的方法
       
       
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
