//
//  FoodViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-01.
//

import UIKit

class FoodViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblFoodView: UITableView!
    let foodName = [("Whopper"),("Rodeo King"),("Triple Whopper"),("Chicken Sandwich"),("Chicken Junior")];
    
    let foodDesc = [("Food Item 01"),("Food Item 02"),("Food Item 03"),("Food Item 04"),("Food Item 05")];
    
    let foodPrice = [(200),(300),(400),(500),(600)]
    
    let foodImage = [UIImage(named: "Whopper"),
                     UIImage(named: "RodeoKing"),
                     UIImage(named: "TripleWhopper"),
                     UIImage(named: "ChickenSandwich"),
                     UIImage(named: "ChickenJunior")]
    let foodOffer = [("0%"),("10%"),("0%"),("0%"),("30%")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFoodView.delegate = self;
        tblFoodView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tblFoodView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodName.count;
    }
    
    func tableView(_ tblFoodView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
