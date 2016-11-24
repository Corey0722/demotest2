//
//  meal.swift
//  DemoTest2
//
//  Created by Corey on 2016/7/17.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class meal : UITableViewController {

//   
    @IBOutlet weak var myTableViewMeal: UITableView!
 

    var Meal_ID: String?
    var Meal_Price: String?
    var Meal_Pic: UIImage?
    var Rev_Name: String?
    var Rev_Loc: String?
    var Rev_Tel: String?
    var Res_Uid : String?
    var MenuAll = [MealModel]()

    
    //cell要顯示的資料陣列
    

    

    
    //菜單資訊中的label
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加入cell要顯示的資料到陣列中
        
        GetMenuInfo()
print(Res_Uid)
        
    }
    
    

    func GetMenuInfo (){
        FIRDatabase.database().reference().child("User_Res").child(Res_Uid!).child("Res_Menu").observeEventType(.ChildAdded, withBlock: {(
            snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let MenuInfo = MealModel()
                print(snapshot)
                
                
                MenuInfo.setValuesForKeysWithDictionary(dictionary)
                self.MenuAll.append(MenuInfo)
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
        
        //回傳tableview總數
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuAll.count
        
        //回傳ＣＥＬＬ總數
        
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableViewMeal.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MealCell
        //將類別myTableViewMeal轉型為MealCell
        
        let Menu_All = MenuAll[indexPath.row]
   
        
        cell.MealPrice.text = Menu_All.MealPrice
        cell.MealName.text = Menu_All.MealId
 
              return cell
        //回傳cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MealInformationSegue"{
            if let indexPath = self.myTableViewMeal.indexPathForSelectedRow{
            let navVC = segue.destinationViewController as! MealInformation
   
                let Menu_All = MenuAll[indexPath.row]
                navVC.Rv_Name = Rev_Name
                navVC.Rv_Loc = Rev_Loc
                navVC.Rv_Tel = Rev_Tel
                navVC.Rv_UID = Res_Uid
                navVC.MiAboutName = Menu_All.MealAbout
                navVC.MiIDName = Menu_All.MealId
                navVC.MiPriceName = Menu_All.MealPrice
                
               
                
            }
            
        }
    }}
  