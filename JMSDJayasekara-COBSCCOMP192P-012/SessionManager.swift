//
//  SessionManager.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-07.
//

import Foundation
public struct User: Codable {
    let status :String?
    
    enum CodingKeys: String, CodingKey {
        case status
    }
}

class SessionManager{
    class func saveUserSession(_ status: String) {
        var user = [User]()
        let newTask = User(status: status)
        user.append(newTask)
        if let jsonData = try? JSONEncoder().encode(user){
            let data = String(data: jsonData, encoding: String.Encoding.utf8)
            UserDefaults.standard.set(true, forKey: "Login")
            UserDefaults.standard.set(data, forKey: "Session")
        } else {
            NSLog("JSON SERIALIZATION FAILED")
        }
    }
    
    //Retrieve the current usersession JSON from UserDefaults and returns it as User Type
    class func getUserSesion() -> Bool? {
        
        //Check whether previous sessions exists
        guard let session = UserDefaults.standard.string(forKey: "Session")
        else {
            NSLog("No previous sessions found")
            return false
        }
        
        NSLog("Previous Sessions found")

        //Serializae the JSON string and decode it as User Type
        if (try? JSONDecoder().decode(String.self, from: session.data(using: .utf8)!)) != nil {
            return true
        }
        return false;
    }
}
