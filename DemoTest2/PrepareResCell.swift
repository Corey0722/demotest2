//
//  PrepareResCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/26.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class PrepareResCell: UITableViewCell {

    @IBOutlet weak var GuestCountInOrder: UILabel!
    @IBOutlet weak var ResTelInOrder: UILabel!
    @IBOutlet weak var MealPriceInOrder: UILabel!
    @IBOutlet weak var MealCountInOrder: UILabel!
    @IBOutlet weak var MealNameInOrder: UILabel!
    @IBOutlet weak var ResLocInOrder: UILabel!
    @IBOutlet weak var ResNameInOrder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
