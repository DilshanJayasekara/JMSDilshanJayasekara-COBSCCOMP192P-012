//
//  ShowFoodDetailsViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-07.
//

import UIKit
import Firebase
class ShowFoodDetailsViewController: UIViewController {
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var FoodImage: UIImageView!
    
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    let db = Firestore.firestore()
    @IBOutlet weak var ImageView: UIView!
    @IBAction func btnAddClick(_ sender: Any) {
        addToCart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.reloadInputViews()
        print(UserDefaults.standard.string(forKey: "foodCategory") ?? "")
        print(UserDefaults.standard.string(forKey: "foodId") ?? "")
        showDetails()
        // Do any additional setup after loading the view.
    }
    func  showDetails(){
       
        self.db.collection("Foods").document(UserDefaults.standard.string(forKey: "foodCategory") ?? "").collection(UserDefaults.standard.string(forKey: "foodCategory") ?? "").addSnapshotListener { [self] (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        for document in snapshot!.documents{
                        if(UserDefaults.standard.string(forKey: "foodId") == document.get("name") as? String)
                            {
                            lblFoodName.text = document.get("name") as? String
                            lblPrice.text = "Rs. \(String(describing: document.get("price") ?? ""))"
                            lblDescription.text = document.get("description") as? String
                            let offer = document.get("offer") as? String
                            FoodImage.image  = UIImage(named: document.get("image" ) as! String)
                        if(offer == ("0%"))
                        {
                            lblOffer.isHidden = true;
                        }
                        else
                        {
                            lblOffer.text = "\(offer ?? "0"))% off"
                        }
                        }
                        }
                    }
                }
            }
        print(UserDefaults.standard.string(forKey: "foodId") ?? "")
    }
    func addToCart(){
        
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
