//
//  CartTableViewCell.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-02.
//

import UIKit
protocol YourCellDelegate : class {
    func didPressMinButton(_ tag: Int)
    func didPressAddButton(_ tag: Int)
    }

class CartTableViewCell: UITableViewCell {

    var cellDelegate: YourCellDelegate?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBAction func btnMinusClick(_ sender: UIButton) {
        cellDelegate?.didPressMinButton(sender.tag)
    }
    
    @IBAction func btnAddClick(_ sender: UIButton) {
        cellDelegate?.didPressAddButton(sender.tag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
