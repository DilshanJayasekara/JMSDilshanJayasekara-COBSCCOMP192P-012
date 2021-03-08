//
//  ProfileViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-08.
//

import UIKit
import Firebase
public struct Item: Codable {
    let item :String?
    let price  :String?
    let date : String?
    let total : String?

    enum CodingKeys: String, CodingKey {
        case item
        case price
        case date
        case total
    }
}
class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblItemView: UITableView!
    
    @IBOutlet weak var profileImage: UIImageView!
    let db = Firestore.firestore()
    @IBAction func btnEditClick(_ sender: Any) {
        print("Click Edit")
        self.performSegue(withIdentifier: "ProfiletoUploadImage", sender: nil)
    }
    var items = [Item]()
    @IBAction func btnClickLogOut(_ sender: Any) {
        self.performSegue(withIdentifier: "HometoLogin", sender: nil)
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "mobile")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblItemView.delegate = self
        tblItemView.dataSource = self
        getItemDetails()
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
               let url = URL(string: urlString)else {
             return
         }
         let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             DispatchQueue.main.async {
                self.profileImage.layer.masksToBounds = true
                self.profileImage.layer.cornerRadius = self.profileImage.bounds.width / 2
                 let image = UIImage(data: data)
                 self.profileImage.image = image
                
             }
         })
        task.resume()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reciptCell = tblItemView.dequeueReusableCell(withIdentifier: "ReciptCell", for: indexPath) as! ReciptTableViewCell
        reciptCell.lblItem01.text = self.items[indexPath.row].item
        reciptCell.lblPrice01.text = self.items[indexPath.row].price
        reciptCell.lblTotal.text = self.items[indexPath.row].total
        reciptCell.lblDate.text = self.items[indexPath.row].date
        return reciptCell;
    }
    
    func getItemDetails()
    {
        items.removeAll()
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        print("\(mobile ?? "")")
        self.db.collection("Recipts").document("\(mobile ?? "")").collection("Recipt").addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }else{
                    if snapshot?.isEmpty != true {
                        self.items.removeAll()
                        for document in snapshot!.documents{
                            let name = document.get("name")
                            let qty = document.get("qty")
                            let price = document.get("price")
                            let billtot = document.get("billTot")
                            let date    = document.get("date")
                            let newTask = Item(item: name as? String , price: "\(qty ?? "0") x \(price ?? "0")", date: date as? String, total: "\(billtot ?? "")")
                                self.items.append(newTask)
                            }
                    }
                    self.tblItemView.reloadData()
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
