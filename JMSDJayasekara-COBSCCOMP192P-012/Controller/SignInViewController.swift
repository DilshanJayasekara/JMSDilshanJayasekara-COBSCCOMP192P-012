//
//  SignInViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func SignInClick(_ sender: Any) {
        SignUp()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func SignUp(){
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              
              // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                let alert = UIAlertController(title: "Error", message: "Email is not allowed..!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                break
            case .userDisabled:
              // Error: The user account has been disabled by an administrator.
                let alert = UIAlertController(title: "Error", message: "The user account has been disabled by an administrator.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                
            break
            case .wrongPassword:
              // Error: The password is invalid or the user does not have a password.
                let alert = UIAlertController(title: "Error", message: "The password must be 6 characters long or more . ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            break
            case .invalidEmail:
              // Error: Indicates the email address is malformed.
                let alert = UIAlertController(title: "Error", message: "The email address is badly formatted. ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            break
            default:
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription) ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                print("Error: \(error.localizedDescription)")
            }
          } else {
          /*  let refreshAlert = UIAlertController(title: "Message", message: "User signs in successfully..!", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "LOCATION_VIEW" )
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }))*/
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "LOCATION_VIEW" )
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
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

}

