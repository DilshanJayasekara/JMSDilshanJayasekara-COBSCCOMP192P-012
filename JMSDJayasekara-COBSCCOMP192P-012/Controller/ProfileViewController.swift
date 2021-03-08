//
//  ProfileViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-08.
//

import UIKit
import Firebase
public struct Item: Codable {
    let amount :String?

    enum CodingKeys: String, CodingKey {
        case amount
       
    }
}
class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func btnEditClick(_ sender: Any) {
        print("Click Edit")
        self.performSegue(withIdentifier: "ProfiletoUploadImage", sender: nil)
    }
    
    @IBAction func btnClickLogOut(_ sender: Any) {
        self.performSegue(withIdentifier: "HometoLogin", sender: nil)
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "mobile")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
               let url = URL(string: urlString)else {
             return
         }
         let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             DispatchQueue.main.async {
                self.profileImage.layer.masksToBounds = true
                self.profileImage.layer.cornerRadius = self.profileImage.bounds.width / 2
                 let image = UIImage(data: data)
                 self.profileImage.image = image
                
             }
         })
        task.resume()
        // Do any additional setup after loading the view.
    }
    func getItemDetails()
    {
        
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
