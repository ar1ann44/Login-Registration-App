//
//  User.swift
//  LoginRegisterCh13
//
//  Created by Ariana Osuna  on 17/11/26.
//

import Foundation

// model

//MARK: - STRUCT USER
// saves the information of one account

struct User{
    
    let username:String
    let email:String
    let password:String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}
