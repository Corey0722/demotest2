//
//  ViewController.swift
//  DemoTest2
//
//  Created by Corey on 2016/3/24.
//  Copyright © 2016年 Corey. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate ,MKMapViewDelegate ,CLLocationManagerDelegate ,UITableViewDelegate {
    @IBOutlet weak var contentTableView:UITableView!
    
    @IBOutlet var mapView:MKMapView?
    @IBOutlet weak var passwordTextFile: UITextField!
    @IBOutlet weak var accountTextFile: UITextField!
    var locationManager:CLLocationManager?
    let distanceSpan:Double = 500
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let mapView = self.mapView
        {
            mapView.delegate = self
        }
    }
    override func viewDidAppear(animated: Bool)
    {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager!.requestAlwaysAuthorization()
            locationManager!.distanceFilter = 50 // Don't send location updates with a distance smaller than 50 meters between them
            locationManager!.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
        }
    }
    func  textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField === self.accountTextFile {
            self.passwordTextFile.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
            self.performSegueWithIdentifier("CallTabBar", sender: nil)
        }
        return true
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}