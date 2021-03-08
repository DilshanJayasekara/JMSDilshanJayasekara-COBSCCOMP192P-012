//
//  ShowFoodDetailsViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-07.
//

import UIKit
import Firebase
import SPAlert
class ShowFoodDetailsViewController: UIViewController {
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnMobileClick(_ sender: Any) {
        SPAlert.present(title: "Conatcts", message: "You can contact seller using this number : \(mobile)", preset: .custom(UIImage.init(named: "mobile")!))
    }
    var  discount:Int = 0
    var  curramount:Int = 0
    var  currprice:Int = 0
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
    var mobile = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.reloadInputViews()
        //print(UserDefaults.standard.string(forKey: "foodCategory") ?? "")
        //print(UserDefaults.standard.string(forKey: "foodId") ?? "")
        showDetails()
        // Do any additional setup after loading the view.
    }
    func  showDetails(){
       
        print("Show = \(UserDefaults.standard.string(forKey: "foodCategory") ?? "")")
       self.db.collection("Foods").document("\(UserDefaults.standard.string(forKey: "foodCategory") ?? "")").collection("\(UserDefaults.standard.string(forKey: "foodCategory") ?? "")").addSnapshotListener { [self] (snapshot, err) in
                if err != nil {
                   print(err?.localizedDescription ?? "")
               }else{
                 if snapshot?.isEmpty != true {
                    for document in snapshot!.documents{
                        if(UserDefaults.standard.string(forKey: "foodId") == document.get("name") as? String)
                            {
                            lblFoodName.text = document.get("name") as? String
                            lblPrice.text = "Rs. \(document.get("price") ?? "0")"
                            lblDescription.text = document.get("description") as? String
                            let offer = "\(document.get("offer") ?? "0")%"
                            FoodImage.image  = UIImage(named: document.get("image" ) as! String)
                            mobile = document.get("mobile") as? String ?? ""
                            let price = Int("\(document.get("price") ?? "0")") ?? 0
                            let offercal = Int("\(document.get("offer") ?? "0")") ?? 0
                            self.discount = (price * offercal)/100;
                            UserDefaults.standard.set(discount, forKey: "discount")
                            UserDefaults.standard.set(price, forKey: "price")
                       if(offer == ("0%"))
                        {
                            lblOffer.isHidden = true;
                        }
                        else
                        {
                            lblOffer.text = "\(offer) off"
                        }
                        }
                         
                 }
                         
                }
              }
           }
        print(UserDefaults.standard.string(forKey: "foodId") ?? "")
    }
    func addToCart(){
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        let discount = UserDefaults.standard.string(forKey: "discount")
        let price = UserDefaults.standard.string(forKey: "price")
        self.currprice = UserDefaults.standard.integer(forKey: "price")
        //self.currdiscount = UserDefaults.standard.integer(forKey: "discount")
        self.curramount = self.currprice - self.discount;
        print()
        self.db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").document(lblFoodName.text!).setData(["price": Int("\(price ?? "0")") ?? 0,"discount": Int("\(discount ?? "0")") ?? 0 , "name": lblFoodName.text!, "qty" : FieldValue.increment(Int64(1)), "amount" : FieldValue.increment(Int64(self.curramount ))],merge: true){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
               
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
