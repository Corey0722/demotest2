//
//  ResTableView.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/14.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ResTableView: UITableViewController {

    var ResUID = [String]()
    var ResInformation = [Res_Info]()
  
 
    @IBOutlet var ResTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetResInfo()
        print(FIRAuth.auth()?.currentUser?.uid)
    }
   
    func GetResInfo(){
        FIRDatabase.database().reference().child("UserStore").observe(.childAdded, with: {(
            snapshot) in
            print (snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let ResInfo = Res_Info()
                ResInfo.setValuesForKeys(dictionary)
                self.ResInformation.append(ResInfo)
                print(self.ResInformation)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
            })
            }
            })
        FIRDatabase.database().reference().child("UserStore").observe(.childAdded, with: {
            (snapshot) in
                print (snapshot.key)
                self.ResUID.append(snapshot.key)
        

        })
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResInformation.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResTable.dequeueReusableCell(withIdentifier: "RevCell",
        for: indexPath) as! RevCell
        
        //將類別myTableViewMeal轉型為RevCell
    
        let Rev_Info = ResInformation[indexPath.row]
        
   
        cell.RevName.text = Rev_Info.StoreID
        cell.ResTel.text = Rev_Info.StoreTel
        cell.RevLoc.text = Rev_Info.StoreLoc
        
        cell.ResPic.sd_setImage(with: URL(string: Rev_Info.StorePic!))
        
    
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "RevToMenuSegue"{
            if let indexPath = self.ResTable.indexPathForSelectedRow{
                let navVC = segue.destination as!
                meal
               let Rev_NameInMeal = ResInformation[indexPath.row]
              
                navVC.Rev_Name = Rev_NameInMeal.StoreID
                navVC.Rev_Loc = Rev_NameInMeal.StoreLoc
                navVC.Rev_Tel = Rev_NameInMeal.StoreTel
                navVC.Res_Uid = ResUID[indexPath.row]
                navVC.Res_PicName = Rev_NameInMeal.StorePic
            }
    }
    
}    
}
