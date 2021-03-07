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
                        NSLog("Location services disabled")
                        //displayErrorMessage(message: "Application requires location access to continue!")
                    case .authorizedAlways, .authorizedWhenInUse:
                        NSLog("Location services enabled")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "MAIN" )
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    default:
                        //displayErrorMessage(message: "Application requires location access to continue!")
                        NSLog("Location services disabled")
                    }
                } else {
                    //isplayWarningMessage(message: "Please enable location services")
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

