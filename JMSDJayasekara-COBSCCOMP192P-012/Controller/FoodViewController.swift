//
//  FoodViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-01.
//

import UIKit

class FoodViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource
{
    @IBOutlet weak var tblCartView: UITableView!
    @IBOutlet weak var tblFoodView: UITableView!
    @IBOutlet weak var collectionCategoryView: UICollectionView!
    let category = [("Category 01"),("Category 02"),("Category 03"),("Category 04")]
    
    let foodName = [("Whopper"),("Rodeo King"),("Triple Whopper"),("Chicken Sandwich"),("Chicken Junior")];
    
    let foodDesc = [("Food Item 01"),("Food Item 02"),("Food Item 03"),("Food Item 04"),("Food Item 05")];
    
    let foodPrice = [(200),(300),(400),(500),(600)]
    
    let foodImage = [UIImage(named: "Whopper"),
                     UIImage(named: "RodeoKing"),
                     UIImage(named: "TripleWhopper"),
                     UIImage(named: "ChickenSandwich"),
                     UIImage(named: "ChickenJunior")]
    let foodOffer = [("0%"),("10%"),("0%"),("0%"),("30%")]
    let foodQty   = [(1),(1),(1),(1),(1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFoodView.delegate = self;
        tblFoodView.dataSource = self;
        tblFoodView.delegate = self;
        tblCartView.dataSource = self;
        collectionCategoryView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    //This is for food table view and cart
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return foodName.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblFoodView)
        {
            let foodCell = tblFoodView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
            foodCell.foodImageCell.image = self.foodImage[indexPath.row]
            foodCell.lblFoodName.text = self.foodName[indexPath.row]
            foodCell.lblFoodDesc.text = self.foodDesc[indexPath.row]
            foodCell.lblFoodPrice.text = "Rs. " + String(self.foodPrice[indexPath.row])
            foodCell.lblFoodOffer.text = self.foodOffer[indexPath.row]
            if(foodCell.lblFoodOffer.text == ("0%"))
            {
                foodCell.lblFoodOffer.isHidden = true;
            }
            else
            {
                foodCell.lblFoodOffer.text = self.foodOffer[indexPath.row] + " Off"
            }
            return foodCell;
        }
        else if (tableView == tblCartView)
        {
            let cartCell = tblCartView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
            cartCell.lblName.text = self.foodName[indexPath.row]
            cartCell.lblPrice.text = String(self.foodPrice[indexPath.row])
            return cartCell;
        }
        return UITableViewCell()
    }
    //This is for category
    func collectionView(_ collectionCategoryView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionCategoryView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCategoryView.dequeueReusableCell(withReuseIdentifier: "CategaryCell", for: indexPath) as! CategaryCollectionViewCell
        cell.lblFoodCategory.text = self.category[indexPath.row]
        return cell
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
