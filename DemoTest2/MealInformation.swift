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
    var MiPicName:UIImage!
    var MiAboutName:String!
    var Rv_Name:String!
    var Rv_Loc:String!
    var Rv_Tel:String!
    var Rv_UID:String!
    var Check_ResUID : [String] = []
    var Check_MealId : [String] = []
    let databaseOfCart = FIRDatabase.database().reference()
     let GuestUid = FIRAuth.auth()?.currentUser?.uid
     var x: Int = 0
   
    var Order_ToCart = [Order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.MiID.text = MiIDName
        self.MiPrice.text = MiPriceName
        self.MiPic.image = MiPicName
        self.MiAbout.text = MiAboutName
        self.RvName.text = Rv_Name
        self.RvLoc.text = Rv_Loc
        self.RvTel.text = Rv_Tel
   prepareInfo()
    }
    // MARK: - Table view data source
 

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
        
        
    }
    

    @IBAction func AddCart(sender: AnyObject) {
        if Int(MiCount.text!) > 0{
            
            CheckCartResUID()

               }
    }
    func AlertToAddCart(){
        let alert = UIAlertController(title: "新增至購物車", message: "加入購物車", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { action in self.MealInfoPostCart() }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

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
                let alert = UIAlertController(title: "購物車建立失敗", message: "一次只能加一家餐廳至購物車", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
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
    

    func MealInfoPostCart(){
        let MiID_Name = MiID.text!
        let MiId_Price = MiPrice.text!
        let Mi_Count = MiCount.text!
        let Res_Name_To_Cart = RvName.text!
        let Res_Tel_To_Cart = RvTel.text!
        let Res_Loc_To_Cart = RvLoc.text!
        let CartPost : [String:AnyObject] = ["Cart_MealPrice" : MiId_Price,
                                             "Cart_MealCount" : Mi_Count,
                                             "Cart_ResName" : Res_Name_To_Cart,
                                             "Cart_ResTel" : Res_Tel_To_Cart,
                                             "Cart_ResLoc" : Res_Loc_To_Cart,
                                             "OrderUIDForRes": Rv_UID]
        databaseOfCart.child("User_Guest").child(GuestUid!).child("Guest_Cart").child(MiIDName!).setValue(CartPost)
    }
    func prepareInfo(){
        databaseOfCart.child("User_Guest").child(GuestUid!).child("Guest_Cart").observeEventType(.ChildAdded, withBlock:
            {(snapshot) in
                
                print(snapshot)
                if let  dictionary = snapshot.value as? [String:AnyObject]{
                    let Check = Cart()
                    Check.setValuesForKeysWithDictionary(dictionary)
           
                    self.Check_ResUID.append(Check.OrderUIDForRes!)
                    print (self.Check_ResUID)

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