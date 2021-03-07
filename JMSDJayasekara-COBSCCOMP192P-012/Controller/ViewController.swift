//
//  ViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-02-28.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBAction func AllowClick(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
                   switch locationManager.authorizationStatus {
                   case .restricted, .denied, .notDetermined:
                       print("Location services disabled")
                   case .authorizedAlways, .authorizedWhenInUse:
                       print("Location services enabled")
                   default:
                       print("Location services disabled")
                   }
               } else {
                   print("Please enable location services")
               }
    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestAlwaysAuthorization()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
}

