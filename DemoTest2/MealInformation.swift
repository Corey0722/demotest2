//
//  MealInformation.swift
//  DemoTest2
//
//  Created by Corey on 2016/7/10.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MealInformation: UITableViewController {

   
    @IBOutlet weak var RvLoc: UILabel!

    @IBOutlet weak var RvTel: UILabel!
    @IBOutlet weak var MiCount: UITextField!
    @IBOutlet weak var RvName: UILabel!
    @IBOutlet weak var MiID: UILabel!
    @IBOutlet weak var MiPic: UIImageView!
    @IBOutlet weak var MiAbout: UILabel!
    @IBOutlet weak var MiPrice: UILabel!
    var MiIDName:String!
    var MiPriceName:String!
    var MiPicName:String!
    var MiAboutName:String!
    var StorePicName:String!
    var Rv_Name:String!
    var Rv_Loc:String!
    var Rv_Tel:String!
    var Rv_UID:String!
    var Check_ResUID : [String] = []
    var Check_MealId : [String] = []
    var Check_GuestUID : [String] = []
    let databaseOfCart = FIRDatabase.database().reference()
     let GuestUid = FIRAuth.auth()?.currentUser?.uid
    
   
    var Order_ToCart = [Order]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Check_GuestUID.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.MiID.text = MiIDName
        self.MiPrice.text = MiPriceName
        
        self.MiAbout.text = MiAboutName
        self.RvName.text = Rv_Name
        self.RvLoc.text = Rv_Loc
        self.RvTel.text = Rv_Tel
        self.MiPic.sd_setImage(with: URL(string: MiPicName))
        
        prepareInfo()
        print(GuestUid)
        
    }
    // MARK: - Table view data source
 

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
        
        
    }
    func CheckOrder(){
        FIRDatabase.database().reference().child("UserStore").child(Rv_UID!).child("StoreOrder").observe(.childAdded, with: {(snapshot) in
            print(snapshot.key)
            self.Check_GuestUID.append(snapshot.key)
            
        })
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
                let alert = UIAlertController(title: "錯誤", message: "已有訂單在執行", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                CheckCartResUID()
                
            }
            
        }else{
            CheckCartResUID()
        }
    }

    @IBAction func AddCart(_ sender: AnyObject) {
        if Int(MiCount.text!) > 0{
            
            CheckOrder()

               }
    }
    func AlertToAddCart(){
        let alert = UIAlertController(title: "新增至購物車", message: "加入購物車", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { action in self.MealInfoPostCart() }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

}
//    執行增加購物車
    func CheckCartResUID(){
        if Check_ResUID != []{
        let result = self.Check_ResUID.contains{(value) -> Bool in
            if value == self.Rv_UID {
                print("有餐廳唯一")
                return true
            }
            else{
               print  ("錯誤有複數餐聽")
                return false
     }
            }
//           檢查有沒有同時點兩個餐廳
            if result == false{
                print("只能點一個餐廳")
                let alert = UIAlertController(title: "購物車建立失敗", message: "一次只能加一家餐廳至購物車", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
               AlertToAddCart()
            }
//          執行檢查結果
        }
        else{
MealInfoPostCart()
        }
//        如果資料庫中沒有任何ＵＩＤ直接新增
    }
//    CheckCartResUID over
    func change(_ sender: AnyObject){
    let revealViewControl = self.storyboard?.instantiateViewController(withIdentifier: "mealINFO")as! MealInformation
    self.present(revealViewControl, animated: true, completion: nil)
    
    }

    func MealInfoPostCart(){
        let MiID_Name = MiID.text!
        let MiId_Price = MiPrice.text!
        let Mi_Count = MiCount.text!
        let Res_Name_To_Cart = RvName.text!
        let Res_Tel_To_Cart = RvTel.text!
        let Res_Loc_To_Cart = RvLoc.text!
        
        let CartPostResInfo : [String:AnyObject] = ["CartStoreID" :Res_Name_To_Cart as AnyObject,
                                                "CartStoreTel" : Res_Tel_To_Cart as AnyObject,
                                             "CartStoreLoc" : Res_Loc_To_Cart as AnyObject,
                                             "OrderUIDForStore": Rv_UID as AnyObject,
                                             "CartStorePic" : StorePicName as AnyObject]
        let CartPostMealInfo : [String:AnyObject] = ["MealPrice" : MiId_Price as AnyObject,
                                                     "MealCount" : Mi_Count as AnyObject,
                                                     "MealID" : MiID_Name as AnyObject,
                                                     "MealPic" : MiPicName as AnyObject]
        databaseOfCart.child("UserGuest").child(GuestUid!).child("GuestCart").child("CartStore").setValue(CartPostResInfo)
        databaseOfCart.child("UserGuest").child(GuestUid!).child("GuestCart").child("CartMeal").child(MiID_Name).setValue(CartPostMealInfo)
    }
    func prepareInfo(){
        databaseOfCart.child("UserGuest").child(GuestUid!).child("GuestCart").observe(.childAdded , with:
            {(snapshot) in
                if let dictionary = snapshot.value as? [String:String]{
                    let check = Cart()
                    check.setValuesForKeys(dictionary)
                    self.Check_ResUID.append(check.OrderUIDForStore!)

                    
                }
                
        })

    }
//            if Check_All.contains(){
//                let alert = UIAlertController(title: "錯誤678", message: "請確認格式為信箱或是否已註冊過", preferredStyle: UIAlertControllerStyle.Alert)
//
//
//                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
//                
//                self.presentViewController(alert, animated: true, completion: nil)
//                
//
//            }else{
//                
//            }

    
//        databaseOfCart.child("User_Res").child(GuestUid!).child("Res_Menu").childByAutoId().setValue(OrderMealPost)
        //            databaseOfCart.child("User_Guest").child().child("Order_Guest").childByAutoId().setValue(CartPost)
        
}
