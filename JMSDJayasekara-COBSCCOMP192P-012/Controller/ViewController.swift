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
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            UserDefaults.standard.set(true, forKey: "location")
                   switch locationManager.authorizationStatus {
                   case .restricted, .denied, .notDetermined:
                       print("Location services disabled")
                   case .authorizedAlways, .authorizedWhenInUse:
                       print("Location services enabled")
                    self.performSegue(withIdentifier: "AllowLocationToHome", sender: nil)
                    UserDefaults.standard.set(true, forKey: "location")
                   default:
                       print("Location services disabled")
                   }
               } else {
                   print("Please enable location services")
               }
    }
    override func viewWillAppear(_ animated: Bool) {
        //
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

