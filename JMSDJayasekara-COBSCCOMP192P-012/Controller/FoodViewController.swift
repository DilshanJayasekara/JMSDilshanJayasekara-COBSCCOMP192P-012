//
//  FoodViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-01.
//

import UIKit
import Firebase
public struct Food: Codable {
    let foodName :String?
    let foodDesc: String?
    let foodPrice: String?
    let foodOffer: String?
    let foodCategory: String?
    let foodImage: String?
    
    enum CodingKeys: String, CodingKey {
        case foodName
        case foodDesc
        case foodPrice
        case foodOffer
        case foodCategory
        case foodImage
    }
}

public struct Category: Codable{
    let category : String?
    enum CodingKeys: String, CodingKey {
        case category
    }
}

public struct Cart: Codable{
    let foodName :String?
    let qty :String?
    let price :String?
    let amount :String?
    let discount :String?
    enum CodingKeys: String, CodingKey {
        case foodName
        case qty
        case price
        case amount
        case discount
        
    }
}
class FoodViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, YourCellDelegate
{
    func didPressMinButton(_ tag: Int) {
        print("I have pressed min button with a tag: \(tag)")
    }
    func didPressAddButton(_ tag: Int) {
        print("I have pressed  add button with a tag: \(tag)")
    }
    
    @IBOutlet weak var tblCartView: UITableView!
    @IBOutlet weak var tblFoodView: UITableView!
    @IBOutlet weak var collectionCategoryView: UICollectionView!
    @IBOutlet weak var lblItem: UILabel!
    
    let db = Firestore.firestore()
    var foods = [Food]()
    var carts = [Cart]()
    var categories = [Category]()
   /* let category = [("Category 01"),("Category 02"),("Category 03"),("Category 04")]
    
    let foodName = [("Whopper"),("Rodeo King"),("Triple Whopper"),("Chicken Sandwich"),("Chicken Junior")];
    
    let foodDesc = [("Food Item 01"),("Food Item 02"),("Food Item 03"),("Food Item 04"),("Food Item 05")];
    
    let foodPrice = [(200),(300),(400),(500),(600)]
    
    let foodImage = [UIImage(named: "Whopper"),
                     UIImage(named: "RodeoKing"),
                     UIImage(named: "TripleWhopper"),
                     UIImage(named: "ChickenSandwich"),
                     UIImage(named: "ChickenJunior")]
    let foodOffer = [("0%"),("10%"),("0%"),("0%"),("30%")]
    let foodQty   = [(1),(1),(1),(1),(1)]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFoodView.delegate = self;
        tblFoodView.dataSource = self;
        tblCartView.delegate = self;
        tblCartView.dataSource = self;
        collectionCategoryView.dataSource = self;
        collectionCategoryView.delegate = self;
        getCategoriesDetails()
        self.collectionCategoryView.reloadData()
        self.tblFoodView.reloadData()
        self.tblCartView.reloadData()
        getCartsDetails()
        // Do any additional setup after loading the view.
    }
    //This is for food table view and cart
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblFoodView)
        {
            return foods.count;
        }
        else if(tableView == tblCartView)
        {
            lblItem.text = "Item "+String(carts.count)
            return carts.count;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblFoodView)
        {
            let foodCell = tblFoodView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
            foodCell.foodImageCell.image = UIImage(named: self.foods[indexPath.row].foodImage ?? "")
            foodCell.lblFoodName.text = self.foods[indexPath.row].foodName
            foodCell.lblFoodDesc.text = self.foods[indexPath.row].foodDesc
            foodCell.lblFoodPrice.text = "Rs. \(self.foods[indexPath.row].foodPrice ?? "")"
            foodCell.lblFoodOffer.text = "\(self.foods[indexPath.row].foodOffer ?? "")%"
            if(foodCell.lblFoodOffer.text == ("0%"))
            {
                foodCell.lblFoodOffer.isHidden = true;
            }
            else
            {
                foodCell.lblFoodOffer.text = "\(self.foods[indexPath.row].foodOffer ?? "")% off"
            }
            return foodCell;
        }
        else if (tableView == tblCartView)
        {
            let cartCell = tblCartView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
            cartCell.lblName.text = self.carts[indexPath.row].foodName ?? ""
            cartCell.lblPrice.text = self.carts[indexPath.row].amount ?? ""
            cartCell.lblQty.text =  self.carts[indexPath.row].qty ?? ""
            cartCell.cellDelegate = self
            cartCell.btnRemove.tag = indexPath.row
            cartCell.btnAdd.tag    = indexPath.row
            return cartCell;
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tblFoodView)
        {
            print(foods[indexPath.row].foodName ?? "")
        }
        else if (tableView == tblCartView)
        {
            print("Action")
            print(carts[indexPath.row].foodName ?? "")
        }
    }
    //This is for category
    func collectionView(_ collectionCategoryView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionCategoryView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCategoryView.dequeueReusableCell(withReuseIdentifier: "CategaryCell", for: indexPath) as! CategaryCollectionViewCell
        cell.lblFoodCategory.text = self.categories[indexPath.row].category ?? ""
        return cell
    }
    
    func collectionView(_ collectionCategoryView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categories[indexPath.row].category ?? "")
        getFoodsDetails(category: categories[indexPath.row].category ?? "")
    }
    func getCategoriesDetails()
    {
        categories.removeAll()
        db.collection("Foods").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        self.categories.removeAll()
                        for document in snapshot!.documents{
                            let category = document.documentID
                            let newTask = Category(category: category as? String)
                                self.categories.append(newTask)
                            }
                    }
                    
                    self.collectionCategoryView.reloadData()
                    self.getFoodsDetails(category: self.categories[0].category ?? "")
                }
            }
    }
    func getFoodsDetails(category: String)
    {
        foods.removeAll()
        db.collection("Foods").document(category).collection("RodeoKing").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        self.foods.removeAll()
                        for document in snapshot!.documents{
                            let name = document.get("name")
                            let price = document.get("price")
                            let desc  = document.get("description")
                            let offer = document.get("offer")
                            let image = document.get("image")
                            let newTask = Food(foodName: name as? String, foodDesc: desc as? String, foodPrice: price as? String, foodOffer: offer as? String, foodCategory: category as? String, foodImage: image as? String)
                                self.foods.append(newTask)
                            }
                    }
                    self.tblFoodView.reloadData()
                }
            }
    }
    func getCartsDetails()
    {
        carts.removeAll()
        db.collection("Carts").document("0776061579").collection("0776061579").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        self.carts.removeAll()
                        for document in snapshot!.documents{
                            let name = document.documentID
                            let price = document.get("price")
                            let amount = document.get("amount")
                            let qty = document.get("qty")
                            let discount = document.get("discount")
                            let newTask = Cart(foodName: name as? String, qty: qty as? String, price: price as? String, amount: amount as? String, discount: discount as? String)
                            self.carts.append(newTask)
                            }
                    }
                    self.tblCartView.reloadData()
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
