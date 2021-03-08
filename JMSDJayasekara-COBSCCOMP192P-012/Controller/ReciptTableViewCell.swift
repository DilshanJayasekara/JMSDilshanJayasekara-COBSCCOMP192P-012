//
//  ReciptTableViewCell.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-08.
//

import UIKit

class ReciptTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblItem01: UILabel!
    @IBOutlet weak var lblprice02: UILabel!
    
    @IBOutlet weak var lblItem02: UILabel!
    @IBOutlet weak var lblPrice01: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
