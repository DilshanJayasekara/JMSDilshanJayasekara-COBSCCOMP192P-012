//
//  OrderViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-04.
//

import UIKit
import Firebase
public struct Order: Codable {
    let id :String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
    }
}
class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let db = Firestore.firestore()
    var orders = [Order]()
    
    @IBOutlet weak var tblOrderView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblOrderView.dataSource = self
        tblOrderView.delegate   =  self
        orders.removeAll()
        getOrderDetails()
        self.tblOrderView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tblOrderView)
        {
            let cartCell = tblOrderView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
                        //cartCell.lblStatus.text = self.statusDb[indexPath.row]
                        //cartCell.lblOrderId.text = self.orderIdDb[indexPath.row]
            cartCell.lblOrderId.text = orders[indexPath.row].id
            cartCell.lblStatus.text  = orders[indexPath.row].status
            return cartCell;
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func getOrderDetails(){
        db.collection("Orders").document("0776061579").collection("Order").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? nil ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        self.orders.removeAll()
                        for document in snapshot!.documents{
                            let documentID = document.documentID
                            let status     = document.get("status")
                            let newTask = Order(id: documentID, status: status as? String)
                                self.orders.append(newTask)
                            }
                    }
                    self.tblOrderView.reloadData()
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
