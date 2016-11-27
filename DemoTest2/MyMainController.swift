//
//  MyMainController.swift
//  DemoTest2
//
//  Created by Corey on 2016/11/22.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyMainController: UITableViewController {

    @IBAction func SignOut(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        handleLogin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FIRAuth.auth()?.currentUser?.uid)
        if FIRAuth.auth()?.currentUser?.uid == nil{
            performSelector(#selector(handleLogin) , withObject: nil,
                            afterDelay:  0)
        }
        else{
            print (FIRAuth.auth()?.currentUser?.uid)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  
    func  handleLogin(){
        do{
            try! FIRAuth.auth()?.signOut()
        } catch let louginRrror{
            print (louginRrror)
        }
        let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.presentViewController(loginController, animated: true, completion: nil)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
