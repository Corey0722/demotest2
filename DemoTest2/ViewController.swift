//
//  ViewController.swift
//  DemoTest2
//
//  Created by Corey on 2016/3/24.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import MapKit
import Firebase
//import FirebaseAuth
//import FirebaseDatabase

class ViewController: UIViewController , UITextFieldDelegate ,MKMapViewDelegate ,CLLocationManagerDelegate ,UITableViewDelegate {
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var contentTableView:UITableView!
    
    
    @IBOutlet var mapView:MKMapView?
   
    var locationManager:CLLocationManager?
    let distanceSpan:Double = 500
//    let ref = FIRDatabase.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if locationManager == nil {
//            locationManager = CLLocationManager()
//            locationManager!.delegate = self
//            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//            locationManager!.requestAlwaysAuthorization()
//            locationManager!.distanceFilter = 50 // Don't send location updates with a distance smaller than 50 meters between them
//            locationManager!.startUpdatingLocation()
//        }

    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let mapView = self.mapView
        {
            mapView.delegate = self
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
//        if locationManager == nil {
//            locationManager = CLLocationManager()
//            locationManager!.delegate = self
//            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//            locationManager!.requestAlwaysAuthorization()
//            locationManager!.distanceFilter = 50 // Don't send location updates with a distance smaller than 50 meters between them
//            locationManager!.startUpdatingLocation()
//        }
//    }
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        if let mapView = self.mapView {
//            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
//            mapView.setRegion(region, animated: true)
//        }
    }
//    func  textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        if textField === self.accountTextFile {
//            self.passwordTextFile.becomeFirstResponder()
//        }
//        else{
//            textField.resignFirstResponder()
//            self.performSegueWithIdentifier("CallTabBar", sender: nil)
//        }
//        return true
//        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Sign(_ sender: AnyObject) {
        
        
            FIRAuth.auth()?.signIn(withEmail: UserName.text!, password: PassWord.text!, completion: {
                user, error in
                if error != nil{
                    
                    
                    let alert  = UIAlertController(title: "錯誤訊息", message: "密碼錯誤", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "重試", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    print("正確")
                    
                    let alert = UIAlertController(title: "歡迎登入", message: "將轉跳至主畫面", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { action in self.SignSuccess()}
                        ))
                    
                    self.present(alert, animated: true, completion: nil)
                    //                let revealViewControl = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarStoryboard")as! UITabBarController
                    //                self.presentViewController(revealViewControl, animated: true, completion: nil)
                    //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    //                appDelegate.window?.rootViewController = revealViewControl
                }
                
            })
        
    }
    
    @IBAction func CreateAccount(_ sender: AnyObject) {
        let revealViewControl = self.storyboard?.instantiateViewController(withIdentifier: "CreateEMailView")as! CreateUserEMailViewController
        self.present(revealViewControl, animated: true, completion: nil)
        
  
     
    }
  
    func SignSuccess()  {
        
        
        let revealViewControl = self.storyboard?.instantiateViewController(withIdentifier: "TabBarStoryboard")as! UITabBarController
        self.present(revealViewControl, animated: true, completion: nil)
    }

}
