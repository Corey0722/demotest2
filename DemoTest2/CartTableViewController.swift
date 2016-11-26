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
    
    var CartRes = [Cart]()
    var CartMeal = [MealModel]()
    var GuestToOrder = [OrderGuestModel]()
    var MealToOrder = [MealModel]()
    var ResUID : String?
    var GuestCount : String?
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getvalueToDictionary()
        self.CartRes.removeAll()
        self.CartMeal.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func AddOrder(sender: AnyObject) {
        self.CartTable.reloadData()
        if CartRes == []{
            let alert = UIAlertController(title: "訂單失敗", message: "請先新建購物車！", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
        let alert = UIAlertController(title: "即將建立訂單", message: "訂單完成不得更改！", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { action in self.OrderCreate() }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func OrderCreate(){
        if GuestCount != ""{
        let alert = UIAlertController(title: "完成！", message: "建立成功！", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { action in self.CartMealToOrder()}))
        self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "建立錯誤", message: "請輸入用餐人數", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func getvalueToDictionary(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
FIRDatabase.database().reference().child("User_Guest").child(Guest_Uid!).child("Guest_Cart").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:String]{
                let Cart_Res = Cart()
                Cart_Res.setValuesForKeysWithDictionary(dictionary)
                self.CartRes.append(Cart_Res)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("User_Guest").child(Guest_Uid!).child("Guest_Cart").child("Cart_Meal").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Meal = MealModel()
                Cart_Meal.setValuesForKeysWithDictionary(dictionary)
                self.CartMeal.append(Cart_Meal)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
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
      
        return CartMeal.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0 {
            let Cart_Res = CartRes[indexPath.row]
     self.tableView.rowHeight = 381
         let cell = CartTable.dequeueReusableCellWithIdentifier("ResCart" , forIndexPath:  indexPath) as! ResCartCell
            let  Cart_Meal = CartMeal[indexPath.row]
             print(CartRes)
            cell.ResName.text = Cart_Res.Cart_ResName
            cell.ResLoc.text = Cart_Res.Cart_ResLoc
            cell.ResTel.text = Cart_Res.Cart_ResTel
            cell.MealID.text = Cart_Meal.MealId
            cell.MealCount.text = Cart_Meal.MealCount
            cell.MealPrice.text = Cart_Meal.MealPrice
            GuestCount = cell.Guest_Count.text
            ResUID = Cart_Res.OrderUIDForRes
            
            return cell
        }else{
      self.tableView.rowHeight = 95
         let cell = CartTable.dequeueReusableCellWithIdentifier("MealCart", forIndexPath:  indexPath) as! MealCartCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.MealName.text = Cart_Meal.MealId
            cell.MealCount.text = Cart_Meal.MealCount
            cell.MealPrice.text = Cart_Meal.MealPrice
            
            return cell
        }
    }
           func CartMealToOrder(){
        let GuestUID = FIRAuth.auth()?.currentUser?.uid
         FIRDatabase.database().reference().child("User_Guest").child(GuestUID!).child("Guest_Cart").child("Cart_Meal").observeEventType(.ChildAdded, withBlock: {
            (snapshot) in
            print(snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let CartToOrder = MealModel()
                CartToOrder.setValuesForKeysWithDictionary(dictionary)
                self.MealToOrder.append(CartToOrder)
                let MealOrder : [String:AnyObject] = ["MealId" : CartToOrder.MealId!,
                                                      "MealCount" : CartToOrder.MealCount!,
                                                      "MealPrice" : CartToOrder.MealPrice!]
        
        FIRDatabase.database().reference().child("User_Guest").child(GuestUID!).observeEventType(.Value, withBlock: {
            (snapshot) in
            print (snapshot)
            print(snapshot.value)
            print(snapshot.key)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let CartGuest = OrderGuestModel()
                CartGuest.setValuesForKeysWithDictionary(dictionary)
                self.GuestToOrder.append(CartGuest)
                print(CartGuest)
                let ToOrder : [String:AnyObject] = ["Guest_Name" : CartGuest.Guest_Name!,
                                                    "Guest_Count" : self.GuestCount!,
                                                    "Guest_UID" : GuestUID!,
                                                    "Guest_EMail" : CartGuest.Guest_EMail!]
                FIRDatabase.database().reference().child("User_Res").child(self.ResUID!).child("Res_Order").child(GuestUID!).child("Order_Guest").setValue(ToOrder)
                FIRDatabase.database().reference().child("User_Res").child(self.ResUID!).child("Res_Order").child(GuestUID!).child("Order_Meal").child(CartToOrder.MealId!).setValue(MealOrder)
//                FIRDatabase.database().reference().child("User_Res").child(self.ResUID!).child("Res_Order").child(CartToOrder.MealId!).setValue(MealOrder)
                
            }
            
        })
                
            }
            
         })

        
        
    }
}
    