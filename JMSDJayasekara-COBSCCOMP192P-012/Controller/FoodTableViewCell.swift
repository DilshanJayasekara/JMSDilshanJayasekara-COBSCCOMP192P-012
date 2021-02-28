//
//  FoodTableViewCell.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-01.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageCell: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodDesc: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodOffer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
