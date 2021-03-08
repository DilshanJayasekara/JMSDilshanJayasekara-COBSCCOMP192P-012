//
//  Cart.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-07.
//

import Foundation
import Firebase
public class CartCal
{
    let db = Firestore.firestore()
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
                                let price =  Double("\(String(describing: document.get("price")))")
                                
                                let offer = document.get("discount") as? String
                                
                            }
                        }
                    }
                }
            }
        return 0
    }
}
