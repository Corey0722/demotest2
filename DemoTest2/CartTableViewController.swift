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
    var Check_GuestUID : [String] = []
    var ResUID : String?
    var RemoveButtom : UIButton?
    var GuestCount : String?
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.CartRes.removeAll()
        self.CartMeal.removeAll()
        self.Check_GuestUID.removeAll()
        getvalueToDictionary()
        self.CartTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func AddOrder(sender: AnyObject) {
        self.CartTable.reloadData()
        self.Check_GuestUID.removeAll()
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).observeEventType(.ChildAdded, withBlock: {(snapshot) in
            print(snapshot.value)
            self.Check_GuestUID.append(snapshot.key)
            
        })

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
            CheckGuestUID()
            
        }else{
            let alert = UIAlertController(title: "建立錯誤", message: "請輸入用餐人數", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func CheckGuestUID(){
        let GuestUID = FIRAuth.auth()?.currentUser?.uid
        
        if Check_GuestUID != []{
            let result = self.Check_GuestUID.contains{(value) -> Bool in
                if value == GuestUID {
                    print("已有訂單進行")
                    return true
                }
                else{
                    print  ("沒有訂單進行")
                    return false
                }}
            
                if result == true{
                    let alert = UIAlertController(title: "錯誤", message: "已有訂單在執行", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "完成", message: "已完成您的訂單", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { action in self.CartMealToOrder() }))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            
        }else{
            let alert = UIAlertController(title: "完成", message: "已完成您的訂單", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { action in self.CartMealToOrder() }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func getvalueToDictionary(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
FIRDatabase.database().reference().child("UserGuest").child(Guest_Uid!).child("GuestCart").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:String]{
                let Cart_Res = Cart()
                Cart_Res.setValuesForKeysWithDictionary(dictionary)
                self.CartRes.append(Cart_Res)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserGuest").child(Guest_Uid!).child("GuestCart").child("CartMeal").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Meal = MealModel()
                Cart_Meal.setValuesForKeysWithDictionary(dictionary)
                self.CartMeal.append(Cart_Meal)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserStore").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            print (snapshot.key)
            
        })
           }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
 
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return CartMeal.count
    }
    func RemoveCart(sender:UIButton){
        let GuestUID = FIRAuth.auth()?.currentUser?.uid
        if Check_GuestUID != []{
            let result = self.Check_GuestUID.contains{(value) -> Bool in
                if value == GuestUID {
                    print("已有訂單進行")
                    return true
                }
                else{
                    print  ("沒有訂單進行")
                    return false
                }}
            if result == true{
                let alert = UIAlertController(title: "錯誤", message: "已有訂單在執行", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                let  GuestUID = FIRAuth.auth()?.currentUser?.uid
                FIRDatabase.database().reference().child("UserGuest").child(GuestUID!).child("GuestCart").removeValue()
                self.CartRes.removeAll()
                self.CartMeal.removeAll()
                self.tableView.reloadData()
        
            }
            
        }else{
            let  GuestUID = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("UserGuest").child(GuestUID!).child("GuestCart").removeValue()
            self.CartRes.removeAll()
            self.CartMeal.removeAll()
            self.tableView.reloadData()
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0 {
            let Cart_Res = CartRes[indexPath.row]
     self.tableView.rowHeight = 381
         let cell = CartTable.dequeueReusableCellWithIdentifier("ResCart" , forIndexPath:  indexPath) as! ResCartCell
            let  Cart_Meal = CartMeal[indexPath.row]
             print(CartRes)
            cell.ResName.text = Cart_Res.CartStoreID
            cell.ResLoc.text = Cart_Res.CartStoreLoc
            cell.ResTel.text = Cart_Res.CartStoreTel
            cell.MealID.text = Cart_Meal.MealID
            cell.MealCount.text = Cart_Meal.MealCount
            cell.MealPrice.text = Cart_Meal.MealPrice
            cell.StorePic.sd_setImageWithURL(NSURL(string:Cart_Res.CartStorePic!))
            cell.MealPic.sd_setImageWithURL(NSURL(string: Cart_Meal.MealPic!))
            cell.RemoveCart.addTarget(self, action: #selector(self.RemoveCart(_:)), forControlEvents: .TouchUpInside)
            GuestCount = cell.Guest_Count.text
            ResUID = Cart_Res.OrderUIDForStore
            
            return cell
        }else{
      self.tableView.rowHeight = 95
         let cell = CartTable.dequeueReusableCellWithIdentifier("MealCart", forIndexPath:  indexPath) as! MealCartCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.MealName.text = Cart_Meal.MealID
            cell.MealCount.text = Cart_Meal.MealCount
            cell.MealPrice.text = Cart_Meal.MealPrice
            cell.MealPic.sd_setImageWithURL(NSURL(string: Cart_Meal.MealPic!))
            
            return cell
        }
    }
func CartMealToOrder(){
        let GuestUID = FIRAuth.auth()?.currentUser?.uid
         FIRDatabase.database().reference().child("UserGuest").child(GuestUID!).child("GuestCart").child("CartMeal").observeEventType(.ChildAdded, withBlock: {
            (snapshot) in
            print(snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let CartToOrder = MealModel()
                CartToOrder.setValuesForKeysWithDictionary(dictionary)
                self.MealToOrder.append(CartToOrder)
                let MealOrder : [String:AnyObject] = ["MealID" : CartToOrder.MealID!,
                                                      "MealCount" : CartToOrder.MealCount!,
                                                      "MealPrice" : CartToOrder.MealPrice!,
                    "MealPic" : CartToOrder.MealPic!]
        
        FIRDatabase.database().reference().child("UserGuest").child(GuestUID!).observeEventType(.Value, withBlock: {
            (snapshot) in
            print (snapshot)
            print(snapshot.value)
            print(snapshot.key)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let CartGuest = OrderGuestModel()
                CartGuest.setValuesForKeysWithDictionary(dictionary)
                self.GuestToOrder.append(CartGuest)
                print(CartGuest)
                let ToOrder : [String:AnyObject] = ["GuestID" : CartGuest.GuestID!,
                                                    "GuestCount" : self.GuestCount!,
                                                    "GuestUID" : GuestUID!,
                                                    "GuestMail" : CartGuest.GuestMail!]
                FIRDatabase.database().reference().child("UserStore").child(self.ResUID!).child("StoreOrder").child(GuestUID!).child("OrderGuest").setValue(ToOrder)
                FIRDatabase.database().reference().child("UserStore").child(self.ResUID!).child("StoreOrder").child(GuestUID!).child("OrderMeal").child(CartToOrder.MealID!).setValue(MealOrder)
//                FIRDatabase.database().reference().child("User_Res").child(self.ResUID!).child("Res_Order").child(CartToOrder.MealId!).setValue(MealOrder)
                
            }
            
        })
                
            }
            
         })

        
        
    }
}
    