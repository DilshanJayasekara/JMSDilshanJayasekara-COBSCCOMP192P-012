//
//  LocationViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var locationView: LocationView!
    
    var locationService: LocationService?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.didTapAllow = { [weak self] in
            self?.locationService?.requestLocationAuthorization()
        }

        locationService?.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService?.getLocation()
            }
        }

        locationService?.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }
        // Do any additional setup after loading the view.
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
