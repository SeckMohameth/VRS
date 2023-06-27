//
//  User.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/2/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    //let fullname: String
    let email: String
    let username: String
    //let followers: Int
    //let following: Int
    let creationDate: Date?
    
    
}

//extension User {
//    static var MOK_USER = User(id: NSUUID().uuidString, email: "mo@gmail.com", username: "mseck", creationDate: "")
//}
