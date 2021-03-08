//
//  SignInViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit
import Firebase
import SPAlert
class SignInViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    let db = Firestore.firestore()
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func SignInClick(_ sender: Any) {
        SignIn()
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func SignIn(){
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              
              // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                SPAlert.present(title: "Error", message: "Email is not allowed..!", preset: .custom(UIImage.init(named: "Error")!))
                break
            case .userDisabled:
              // Error: The user account has been disabled by an administrator.
                SPAlert.present(title: "Error", message: "The user account has been disabled by an administrator.", preset: .custom(UIImage.init(named: "Error")!))
                
            break
            case .invalidEmail:
                SPAlert.present(title: "Error", message: "The email address is badly formatted.", preset: .custom(UIImage.init(named: "Error")!))
            break
            case .wrongPassword:
              // Error: The password is invalid or the user does not have a password.
                SPAlert.present(title: "Error", message: "The user name or password is invalid ", preset: .custom(UIImage.init(named: "Error")!))
            break
            
            default:
                SPAlert.present(title: "Error", message: "\(error.localizedDescription)", preset: .custom(UIImage.init(named: "Error")!))
                print("Error: \(error.localizedDescription)")
            }
          } else {
            self.getDetails()
           SPAlert.present(title: "Message", message: "User signs in successfully..!", preset: .custom(UIImage.init(named: "correct")!))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if(UserDefaults.standard.bool(forKey: "location"))
                {
                    self.performSegue(withIdentifier: "SignIntoHome", sender: nil)
                }
                else
                {
                    self.performSegue(withIdentifier: "LogintoAllowLocation", sender: nil)
                }
            })
          }
    }
}
    func  getDetails() {
        db.collection("Users").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? nil ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        for document in snapshot!.documents{
                            if( document.documentID == self.txtEmail.text!)
                            {
                                let mobile  = document.get("mobile")
                                let user    = document.documentID
                                let defaults = UserDefaults.standard
                                defaults.set(user, forKey: "useId")
                                defaults.set(mobile, forKey: "mobile")
                                defaults.set(true, forKey: "login")
                                defaults.set(self.txtEmail.text!, forKey: "Email")
                                }
                                
                            }
                            
                        }
                    }
                }
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



