//
//  LocationView.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit

@IBDesignable class LocationView: BaseView {


    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var allowButton: UIButton!
    var didTapAllow: (() -> Void)?

    @IBAction func allowAction(_ sender: UIButton) {
        didTapAllow?()
    }
    
    @IBAction func denyAction(_ sender: Any) {
    }
    
}
