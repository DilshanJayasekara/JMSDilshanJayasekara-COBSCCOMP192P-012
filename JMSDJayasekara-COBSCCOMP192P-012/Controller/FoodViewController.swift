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
class FoodViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,YourCellDelegate
{
    
    func didPressMinButton(_ tag: Int) {
        print("I have pressed min button with a tag: \(tag)")
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        let amount = Int("\(carts[tag].amount ?? "0")") ?? 0
        let price  = Int("\(carts[tag].price ?? "0")") ?? 0
        let discount = Int("\(carts[tag].discount ?? "0")") ?? 0
        print("Discount :\(discount)")
        let curramount = (amount - (price - discount));
        let cartRef = db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").document(carts[tag].foodName!)
        cartRef.updateData([
            "name": carts[tag].foodName ?? "",
            "qty":  FieldValue.increment(Int64(-1)),
            "price": Int(carts[tag].price ?? "0") ?? 0,
            "amount": curramount,
            "discount": discount
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.getCartsDetails()
                self.tblCartView.reloadData()
            }
        }
        if(curramount == 0 || curramount < 0)
        {
            print("remove")
            db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").document(carts[tag].foodName!).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.getCartsDetails()
                    self.tblCartView.reloadData()
                }
            }
        }
       
    }
    func didPressAddButton(_ tag: Int) {
        print("I have pressed  add button with a tag: \(tag)")
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        let amount = Int("\(carts[tag].amount ?? "0")") ?? 0
        let price  = Int("\(carts[tag].price ?? "0")") ?? 0
        let discount = Int("\(carts[tag].discount ?? "0")") ?? 0
        let curramount = (amount + (price - discount) );
        let cartRef = db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").document(carts[tag].foodName!)
        cartRef.updateData([
            "name": carts[tag].foodName ?? "",
            "qty":  FieldValue.increment(Int64(1)),
            "price": Int(carts[tag].price ?? "0") ?? 0,
            "amount": curramount,
            "discount": discount
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.getCartsDetails()
            }
        }
        self.getCartsDetails()
    }
    @IBOutlet weak var btnOrder: UIButton!
    
    @IBOutlet weak var tblCartView: UITableView!
    @IBOutlet weak var tblFoodView: UITableView!
    @IBOutlet weak var collectionCategoryView: UICollectionView!
    @IBOutlet weak var lblItem: UILabel!
    
    let db = Firestore.firestore()
    var foods = [Food]()
    var carts = [Cart]()
    var categories = [Category]()
    var Totamount :Int = 0
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
    @IBAction func btnOrderClick(_ sender: Any) {
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        let randomInt = Int.random(in: 1000..<10000)
        if(carts.isEmpty != true)
        {
            db.collection("Orders").document("\(mobile ?? "")").collection("Order").document("\(randomInt )").setData([
                "orderId": randomInt,
                "status": "15 min left"
            ], merge: true)
        }
        if(carts.isEmpty != true)
        { let count = 0;
            for rec in self.carts{
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let dateString = formatter.string(from: Date())
                db.collection("Recipts").document("\(mobile ?? "")").collection("Recipt").document("\(count )").setData([
                    "name": rec.foodName ?? "",
                    "price": rec.price ?? 0,
                    "qty"  : rec.qty ?? 0,
                    "amount": rec.amount ?? 0,
                    "billTot": self.Totamount,
                    "date": dateString
                ], merge: true)
                print("remove")
                db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").document(rec.foodName!).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                        self.getCartsDetails()
                        self.tblCartView.reloadData()
                    }
                }
            }
            
        }
    }
    
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
            cartCell.lblQty.text =  self.carts[indexPath.row].qty ?? "0"
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
            UserDefaults.standard.set(foods[indexPath.row].foodName, forKey: "foodId")
            print(foods[indexPath.row].foodCategory ?? "")
            UserDefaults.standard.set(foods[indexPath.row].foodCategory, forKey: "foodCategory")
            print("Click")
            self.performSegue(withIdentifier: "MaintoDetails", sender: nil)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 50 )
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
                            let newTask = Category(category: category)
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
        db.collection("Foods").document(category).collection(category).addSnapshotListener { (snapshot, err) in
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
                            let newTask = Food(foodName: name as? String, foodDesc: desc as? String, foodPrice: price as? String, foodOffer: offer as? String, foodCategory: category, foodImage: image as? String)
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
        let defaults = UserDefaults.standard
        let mobile = defaults.string(forKey: "mobile")
        print("\(mobile ?? "")")
                db.collection("Carts").document("\(mobile ?? "")").collection("\(mobile ?? "")").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    self.Totamount = 0;
                    if snapshot?.isEmpty != true {
                        self.carts.removeAll()
                        for document in snapshot!.documents{
                                let name = document.documentID
                                let price = document.get("price")
                            let amount = document.get("amount")
                                let qty = document.get("qty")
                                let discount = document.get("discount")
                            let newTask = Cart(foodName: name, qty: "\(qty ?? 0)", price: "\(price ?? 0)", amount: "\(amount ?? 0)", discount: "\(discount ?? 0)")
                                self.carts.append(newTask)
                            let tot = Int("\(amount ?? 0)") ?? 0
                            self.Totamount = self.Totamount + tot
                            
                            self.btnOrder.setTitle("Order Rs. \(self.Totamount )", for: .normal)
                        }
                    
                    
                    self.tblCartView.reloadData()
                }
            }
        
    }
}
    /*
    func CalculateTotalForOneFood(food: String) -> Double
    {
        db.collection("Carts").document(UserDefaults.standard.string(forKey: "mobile") ?? "").collection(UserDefaults.standard.string(forKey: "mobile") ?? "").addSnapshotListener {(snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        for document in snapshot!.documents{
                        if( food == document.get("name") as? String)
                            {
                                let price = document.get("price") ?? 0
                                let offer = document.get("discount") ?? 0
                            self.amount = (price as! Double) - (offer as! Double)
                            }
                        }
                    }
                }
            }
        return self.amount
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
