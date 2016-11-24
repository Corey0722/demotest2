//
//  CartTableViewController.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/23.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CartTableViewController: UITableViewController {

  
    @IBOutlet var CartTable: UITableView!

    var CartMealID : [String] = []
    var CartRes : [String] = []
    var ResIDInCell : String?
    var ResLocInCell : String?
    var ResTelInCell : String?
    var CartForAll = [Cart]()
    

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        GetCartInfo()

        print(CartForAll)
        
        self.CartForAll.removeAll()
        self.CartMealID.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func GetCartInfo(){
        let UserUID = FIRAuth.auth()?.currentUser?.uid
FIRDatabase.database().reference().child("User_Guest").child(UserUID!).child("Guest_Cart").observeEventType(.ChildAdded, withBlock: {(
            snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let CartInfo = Cart()
                CartInfo.setValuesForKeysWithDictionary(dictionary)
                self.CartForAll.append(CartInfo)
                self.CartMealID.append(snapshot.key)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            })
    }

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
        
        return CartForAll.count
    }
//這邊有病！！！
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
    let Cart_All = CartForAll[indexPath.row]
        if indexPath.row == 0 {
            
     self.tableView.rowHeight = 381
         let cell = CartTable.dequeueReusableCellWithIdentifier("ResCart" , forIndexPath:  indexPath) as! ResCartCell
            let  Cart_Meal = CartForAll[indexPath.row]
            print(CartMealID.count)
            cell.ResName.text = Cart_All.Cart_ResName
            print(CartForAll.count)
            cell.ResLoc.text = Cart_All.Cart_ResLoc
            cell.ResTel.text = Cart_All.Cart_ResTel
            cell.MealID.text = CartMealID[indexPath.row]
            cell.MealCount.text = Cart_Meal.Cart_MealCount
            cell.MealPrice.text = Cart_Meal.Cart_MealPrice
            
            
            return cell
        }else{
      self.tableView.rowHeight = 95
         let cell = CartTable.dequeueReusableCellWithIdentifier("MealCart", forIndexPath:  indexPath) as! MealCartCell
            let  Cart_Meal = CartForAll[indexPath.row]
            cell.MealName.text = CartMealID[indexPath.row]
            cell.MealCount.text = Cart_Meal.Cart_MealCount
            cell.MealPrice.text = Cart_Meal.Cart_MealPrice
            
            return cell
        }
        
    }
    

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
