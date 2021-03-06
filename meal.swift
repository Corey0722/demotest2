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
    var Res_PicName : String?
    var MenuAll = [MealModel]()

    
    //cell要顯示的資料陣列
    

    

    
    //菜單資訊中的label
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加入cell要顯示的資料到陣列中
        
        GetMenuInfo()
    }
    
    

    func GetMenuInfo (){
        FIRDatabase.database().reference().child("UserStore").child(Res_Uid!).child("StoreMenu").observe(.childAdded, with: {(
            snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let MenuInfo = MealModel()
                print(snapshot)
                
                
                MenuInfo.setValuesForKeys(dictionary)
                self.MenuAll.append(MenuInfo)
                DispatchQueue.main.async(execute: {
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
        //回傳tableview總數
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuAll.count
        
        //回傳ＣＥＬＬ總數
        
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableViewMeal.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MealCell
        //將類別myTableViewMeal轉型為MealCell
        
        let Menu_All = MenuAll[indexPath.row]
   
        
        cell.MealPrice.text = Menu_All.MealPrice
        cell.MealName.text = Menu_All.MealID
        print(Menu_All.MealPic)
        cell.MealPic.sd_setImage(with: URL(string: Menu_All.MealPic!))
 
              return cell
        //回傳cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MealInformationSegue"{
            if let indexPath = self.myTableViewMeal.indexPathForSelectedRow{
            let navVC = segue.destination as! MealInformation
   
                let Menu_All = MenuAll[indexPath.row]
                navVC.Rv_Name = Rev_Name
                navVC.Rv_Loc = Rev_Loc
                navVC.Rv_Tel = Rev_Tel
                navVC.Rv_UID = Res_Uid
                navVC.MiAboutName = Menu_All.MealAbout
                navVC.MiIDName = Menu_All.MealID
                navVC.MiPriceName = Menu_All.MealPrice
                navVC.MiPicName = Menu_All.MealPic
                navVC.StorePicName = Res_PicName
              
               
                
            }
            
        }
    }}
  
