//
//  LaunchViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-07.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // getDirection()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if(UserDefaults.standard.bool(forKey: "login"))
            {
                print("login")
                self.performSegue(withIdentifier: "LaunchtoHome", sender: nil)
            }
            else
            {
                print("login")
                self.performSegue(withIdentifier: "LaunchtoLogin", sender: nil)
            }
        })
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
