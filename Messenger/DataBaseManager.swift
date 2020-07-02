//
//  DataBaseManager.swift
//  Messenger
//
//  Created by kasper on 6/30/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {
    
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
    private init(){}
    
    
}

// MARK: - Account Managment
extension DataBaseManager{
     /// this function to validate user if his email eists before creating his account
    public func isUserExists (With email : String , completion : @escaping (Bool)->Void){
        
        //this because i put email as a root here  aan dthe root doesn'tcotains [@ ,. ,[,],]
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail     = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(safeEmail).observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.value as?  Dictionary<String , String> != nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    
    /// insert ne user to database
    public func insertUser(with user : ChatAppUser){
        database.child(user.safeEmail).setValue([
            "firstName" : user.firstName ,
            "lastName"  : user.lastName ,
        ])
    }
}


struct ChatAppUser : Codable {
    let firstName         : String
    let lastName          : String
    let emailAddress      : String
    var safeEmail : String {
        
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
   // let profilePictureUrl : String
}
