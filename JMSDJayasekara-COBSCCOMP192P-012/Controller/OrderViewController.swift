//
//  OrderViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let status = [("3 min left"),("Ready to Pick up")]
    let orderId = [("Order Id 01"),("Order Id 02")]
  
    @IBOutlet weak var tblOrderView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblOrderView.dataSource = self
        tblOrderView.delegate   =  self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderId.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tblOrderView)
        {
            let cartCell = tblOrderView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
                        cartCell.lblStatus.text = self.status[indexPath.row]
                        cartCell.lblOrderId.text = self.orderId[indexPath.row]
                        return cartCell;
        }
        else
        {
            return UITableViewCell()
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
