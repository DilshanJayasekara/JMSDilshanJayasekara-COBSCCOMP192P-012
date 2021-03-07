//
//  SignUpViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit
import Firebase
import SPAlert
class SignUpViewController: UIViewController {

    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBAction func SignUpClick(_ sender: Any) {
        SignUp();
    }
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func  SignUp(){
        if txtMobile.text?.isEmpty == true{
            SPAlert.present(title: "Error", message: "Please Enter Correct Mobile Number", preset: .custom(UIImage.init(named: "Error")!))
            return
        }
        if !isValidEmail(txtEmail.text!){
            SPAlert.present(title: "Error", message: "Email is not allowed..!", preset: .custom(UIImage.init(named: "Error")!))
            return
        }
        if !isValidPassword(txtPassword.text!){
            SPAlert.present(title: "Error", message: "Please Enter Correct Password", preset: .custom(UIImage.init(named: "Error")!))
            return
        }
        if(txtPassword.text != txtConfirmPassword.text)
        {
            SPAlert.present(title: "Error", message: "Password Doesn't Match", preset: .custom(UIImage.init(named: "Error")!))
            return
        }
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
          // ...
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                  // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    SPAlert.present(title: "Error", message: "Email is not allowed..!", preset: .custom(UIImage.init(named: "Error")!))
                    break
                case .emailAlreadyInUse:
                    // Error: The email address is already in use by another account.
                    SPAlert.present(title: "Error", message: "The email address is already in use by another account.", preset: .custom(UIImage.init(named: "Error")!))
                    break
                case .invalidEmail:
                    SPAlert.present(title: "Error", message: "The email address is badly formatted", preset: .custom(UIImage.init(named: "Error")!))
                    break
                case .weakPassword:
                    SPAlert.present(title: "Error", message: "The password must be 6 characters long or more .", preset: .custom(UIImage.init(named: "Error")!))
                    break
                default:
                    SPAlert.present(title: "Error", message: "Something is wrong please check your networks", preset: .custom(UIImage.init(named: "Error")!))
                }
              } else {
                print("User signs up successfully")
                self.db.collection("Users").document(self.txtMobile.text!).setData(["email": self.txtEmail.text!,"mobile" : self.txtMobile.text!],  merge: true){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        let defaults = UserDefaults.standard
                        defaults.set(self.txtMobile.text!, forKey: "useId")
                        defaults.set(self.txtMobile.text!, forKey: "mobile")
                        defaults.set(true, forKey: "login")
                        self.dismiss(animated: true)
                        self.performSegue(withIdentifier: "SignUptoHome", sender: nil)
                    }
                }
              }
                return
        
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

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
        
    func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
}
