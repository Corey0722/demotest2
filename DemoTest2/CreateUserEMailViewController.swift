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

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWordCheck: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var EmailTextFile: UITextField!
    
    @IBOutlet weak var UserTel: UITextField!

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
        
        
        let revealViewControl = self.storyboard?.instantiateViewController(withIdentifier: "TabBarStoryboard")as! UITabBarController
        
        self.present(revealViewControl, animated: true, completion: nil)
    }
//註冊成功跳頁
    
    @IBAction func CreateEMail(_ sender: AnyObject) {
        if EmailTextFile.text != ("") {
         
            
              if PassWord.text != ("") {
                if PassWord.text! == PassWordCheck.text!{
                    if  UserName.text != ("") {
                        if UserTel.text != (""){
                                    print ("fuckyou")
                                   CreateFireBaseEmail()
                                    
                        }
                        else{
                            let alert = UIAlertController(title: "註冊錯誤", message: "請輸入使用者電話！", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.default , handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "註冊錯誤", message: "請輸入使用者名稱！", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.default , handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }//UserName值的判斷
                    
                    }
                else{
                    let alert = UIAlertController(title: "註冊錯誤", message: "密碼與驗證密碼不相符！", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.default , handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }//驗整密碼的判斷
            }
            else{
                let alert = UIAlertController(title: "註冊錯誤", message: "密碼不能為空！", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.default , handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }//PassWord值的判斷
            }
         else{
            let alert = UIAlertController(title: "註冊錯誤", message: "信箱不能為空！", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction( UIAlertAction(title: "確定", style:UIAlertActionStyle.default , handler: nil))
            self.present(alert, animated: true, completion: nil)
            
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
        let Guest_Tel = UserTel.text!
       
        
        let postGuest : [String:AnyObject] = ["GuestID" : Guest_Name as AnyObject,
                                         "GuestPassword" : Guest_PassWord as AnyObject,
                                         "GuestMail" : Guest_Email as AnyObject,
                                         "GuestTel" : Guest_Tel as AnyObject
                                         ]
        
        let databaseref = FIRDatabase.database().reference()
        
        
//        let databaserefOfOrder = FIRDatabase.database().reference()
        
        
        
       
        let UserResuid = FIRAuth.auth()?.currentUser?.uid
        databaseref.child("UserGuest").child(UserResuid!).setValue(postGuest)

        
        

        
    }
    func CreateFireBaseEmail(){
        FIRAuth.auth()?.createUser(withEmail: EmailTextFile.text!, password: PassWord.text!, completion: {
            user ,error in
            
            if error != nil
            {
                
                 let alert = UIAlertController(title: "帳號創建失敗！", message: "請確認格式為信箱或是否已註冊過", preferredStyle: UIAlertControllerStyle.alert)
                
                
                alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
               
 
                              
                
            }
            else{
                
                let alert = UIAlertController(title: "註冊成功", message: "已成為會員", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "好", style: UIAlertActionStyle.default, handler: { action in self.CreateSuccess() }))
                self.present(alert, animated: true, completion: nil)
           
                self.SetUserInfo()
              
            }
            }
            //創建帳號
        )
    }
        }
