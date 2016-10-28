//
//  meal.swift
//  DemoTest2
//
//  Created by Corey on 2016/7/17.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit

class meal : UITableViewController {

   
    @IBOutlet var myTableViewMeal: UITableView!
    
    var cellDataMealID = [String]()
    var cellDataPrice = [String]()
    var cellDataPic = [UIImage]()
    var MealButtom : UIButton!

//    var cellDataButton = [UIButton]()
    
    //cell要顯示的資料陣列
    
//    @IBOutlet weak var MIPic: UIImageView!
//    @IBOutlet weak var MIID: UILabel!
//    @IBOutlet weak var MIPrice: UILabel!
   // @IBOutlet weak var MIAbout: UILabel!
    
    //菜單資訊中的label
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let  nib = UINib(nibName: "CustomTableCell", bundle: nil)
        
        // 註冊xib
        
        myTableViewMeal.registerNib(nib, forCellReuseIdentifier: "Cell")
        myTableViewMeal.dataSource = self
        myTableViewMeal.delegate = self
        
        //註冊，forCellReuseIdentifier是TableView中設定的Cell名稱
        
        cellDataMealID.append("海鮮" )
//        cellDataMealID.append("牛肉麵" )
//        cellDataMealID.append("陽春麵" )
        cellDataPrice.append("70")
//        cellDataPrice.append("90")
//        cellDataPrice.append("60")
        cellDataPic.append(UIImage(named: "王品.jpg")!)
//        cellDataPic.append(UIImage(named: "momo壽喜燒.jpg")!)
//        cellDataPic.append(UIImage(named: "momo壽喜燒.jpg")!)
        
        
        //加入cell要顯示的資料到陣列中
//        MealButtom.addTarget(self, action: #selector(showMealInformation(<#T##sender: UIButton##UIButton#>)) , forControlEvents: .TouchUpInside)
//        
//        設定buttom觸發時呼叫方法

        
    }
    
    func showMealInformation(sender:UIButton){
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ＭealInformation")
        
        self.presentViewController(controller!, animated: true, completion: nil)
        
        //製作點擊後顯示餐點資訊Controller的方法
    }
    
//    @IBAction func showMealInformation(sender:AnyObject){
//        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ＭealInformation")
//    
//        self.presentViewController(controller!, animated: true, completion: nil)
//    
//        //製作點擊後顯示餐點資訊Controller的方法
//    }
    
//      @IBAction func ChangeToMealInformation (sender:AnyObject)
//      {
//          let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MealInformation") as! MealInformation
//          self.presentViewController(controller, animated: true, completion: nil)
//      }
//    buttom轉頁方法
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        
        //回傳ＣＥＬＬ總數
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = myTableViewMeal.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableCell;
        
        //將類別myTableViewMeal轉型為CustomTableCell
        
        cell.MealID.text = cellDataMealID[indexPath.row]
        cell.MealPrice.text = cellDataPrice[indexPath.row]
        cell.MealPic.image = cellDataPic[indexPath.row]
//        cell.buttonmore = celldataButtom[indexPath.row]
        
        
        
        
        cell.buttonmore = MealButtom
        MealButtom.addTarget( action: showMealInformation(<#T##sender: UIButton##UIButton#>), forControlEvents: .TouchUpInside)
        
        
//        將CustomTableCell中的兩個ＬＡＢＥＬ值設為ＣＥＬＬＤＡＴＥ陣列中的值
        //awdawdawdwaadawdawd
    
        
//        MIPic.image = cellDataPic[indexPath.row]
//        MIID.text = cellDataMealID[indexPath.row]
//        MIPrice.text = cellDataPrice[indexPath.row]
  
        //將ＭealInformation的label代入對應的值

        return cell
        
        //回傳cell
        
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
