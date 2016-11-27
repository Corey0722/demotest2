//
//  CreateUserEMailViewController.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/17.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class CreateUserEMailViewController: UIViewController {

    @IBOutlet weak var BirthDate: UITextField!
    @IBOutlet weak var BirthMonth: UITextField!
    @IBOutlet weak var BirthYear: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWordCheck: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var EmailTextFile: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.SetUserInfo()
        
//      try!FIRAuth.auth()!.signOut()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func CreateSuccess()  {
        
        
        let revealViewControl = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarStoryboard")as! UITabBarController
        
        self.presentViewController(revealViewControl, animated: true, completion: nil)
    }
//註冊成功跳頁
    
    @IBAction func CreateEMail(sender: AnyObject) {
        if EmailTextFile.text != ("") {
         
            
              if PassWord.text != ("") {
                if PassWord.text! == PassWordCheck.text!{
                    if  UserName.text != ("") {
                        if BirthYear.text != (""){
                            if BirthMonth.text != ("") {
                                if  BirthDate.text != ("") {
                                    print ("fuckyou")
                                   CreateFireBaseEmail()
                                    
                                }
                                else{
                                    let alert = UIAlertController(title: "註冊錯誤", message: "請輸入出生日期！", preferredStyle: UIAlertControllerStyle.Alert)
                                     alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                                    self.presentViewController(alert, animated: true, completion: nil)

                                    
                                }//BirthDate值的判斷
                                
                                    

                                }
                            else{
                                let alert = UIAlertController(title: "註冊錯誤", message: "請輸入出生月份！", preferredStyle: UIAlertControllerStyle.Alert)
                                alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                                self.presentViewController(alert, animated: true, completion: nil)
                                
                                
                                
                            }//BirthMonth值的判斷

                                }
                        else{
                            let alert = UIAlertController(title: "註冊錯誤", message: "請輸入出生年份！", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)

                            }//BirthDate值的判斷
                        }
                    else{
                        let alert = UIAlertController(title: "註冊錯誤", message: "請輸入使用者名稱！", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }//UserName值的判斷
                    
                    }
                else{
                    let alert = UIAlertController(title: "註冊錯誤", message: "密碼與驗證密碼不相符！", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }//驗整密碼的判斷
            }
            else{
                let alert = UIAlertController(title: "註冊錯誤", message: "密碼不能為空！", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }//PassWord值的判斷
            }
         else{
            let alert = UIAlertController(title: "註冊錯誤", message: "信箱不能為空！", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.Default , handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            }
            
            }//EMail值的判斷
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func SetUserInfo (){
        let Guest_Name = UserName.text!
        let Guest_PassWord = PassWord.text!
        let Guest_Email = EmailTextFile.text!
        let MealID = "五"
        let  MealPrice = "278"
//        訂單暫用的值
        let Res_Name = "溫野菜"
        let Res_Tel = "27526301"
        let Res_Loc = "忠孝東路"
        let Res_About = "好吃的火鍋餐廳"
       
        let Res_Email = "cob02082011@yahoo.com"
        let Res_UID = FIRAuth.auth()?.currentUser?.uid
//

       
        let MealStore : [String:AnyObject] = ["MealID" : MealID,
                                             "MealAbout" : "好吃的",
                                             "MealPrice" : MealPrice,
                                             ]

        let MealLast : [String:AnyObject] = [MealID : MealStore]
        
        
        let postGuest : [String:AnyObject] = ["GuestID" : Guest_Name,
                                         "GuestPassword" : Guest_PassWord,
                                         "GuestMail" : Guest_Email,
                                         ]
        
        
        let postRes : [String:AnyObject] = ["StoreID" : Res_Name,
                                              "StoreMail" : Res_Email,
                                              "StoreLoc" : Res_Loc,
                                              "StoreAbout" : Res_About,
                                              "StoreTel" : Res_Tel,
                                              "StoreUID" : Res_UID!,
                                              "StoreMenu" : MealLast]

        
        let databaseref = FIRDatabase.database().reference()
        
        
//        let databaserefOfOrder = FIRDatabase.database().reference()
        
        
        
       
        let UserResuid = FIRAuth.auth()?.currentUser?.uid
        databaseref.child("UserGuest").child(UserResuid!).setValue(postGuest)
        databaseref.child("UserStore").childByAutoId().setValue(postRes)

        
        

        
    }
    func CreateFireBaseEmail(){
        FIRAuth.auth()?.createUserWithEmail(EmailTextFile.text!, password: PassWord.text!, completion: {
            user ,error in
            
            if error != nil
            {
                
                 let alert = UIAlertController(title: "帳號創建失敗！", message: "請確認格式為信箱或是否已註冊過", preferredStyle: UIAlertControllerStyle.Alert)
                
                
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
               
 
                              
                
            }
            else{
                
                let alert = UIAlertController(title: "註冊成功", message: "已成為會員", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "好", style: UIAlertActionStyle.Default, handler: { action in self.CreateSuccess() }))
                self.presentViewController(alert, animated: true, completion: nil)
           
                self.SetUserInfo()
              
            }
            }
            //創建帳號
        )
    }
        }