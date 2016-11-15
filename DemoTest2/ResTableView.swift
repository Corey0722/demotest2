//
//  ResTableView.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/14.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class ResTableView: UITableViewController {

   
    @IBOutlet var myRevTableView: UITableView!
    
    
    var cellDataRevID = [String]()
//    var cellDataRevPic = [UIImage]()
    var cellDataRevLoc = [String]()
    
    var Rev_Name: String?
    var Rev_Loc: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellDataRevID.append("溫野菜忠孝店")
        cellDataRevID.append("溫野菜信義店")
        cellDataRevID.append("溫野菜林口店")
        cellDataRevLoc.append("台北市大安區忠孝東路")
        cellDataRevLoc.append("台北市信義區松高路")
        cellDataRevLoc.append("新北市林口區")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myRevTableView.dequeueReusableCellWithIdentifier("RevCell",
        forIndexPath: indexPath)as! RevCell
        //將類別myTableViewMeal轉型為RevCell
        
        Rev_Name = cellDataRevID[indexPath.row]
        Rev_Loc = cellDataRevLoc[indexPath.row]
        cell.RevName.text = Rev_Name
        cell.RevLoc.text = Rev_Loc
        return cell
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?){
        if segue.identifier == "RevToMenuSegue"{
            if let indexPath = self.myRevTableView.indexPathForSelectedRow{
                let navVC = segue.destinationViewController as!
                meal
                navVC.Rev_Name = cellDataRevID[indexPath.row]
                
            }
    }
}    
}
