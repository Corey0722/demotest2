//
//  RevCell.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/15.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class RevCell: UITableViewCell {

    @IBOutlet weak var RevFav: UISwitch!
   
    @IBOutlet weak var RevLoc: UILabel!
    @IBOutlet weak var RevName: UILabel!
    @IBOutlet weak var RevPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
