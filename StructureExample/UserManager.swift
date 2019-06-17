//
//  UserManager.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let password: String
    let photoData: Data
}

struct UserManager {
    let api: API
    
    func currentUser(completion: @escaping (User?) -> ()) {
        api.fetchCurrentUser(completion: completion)
    }
    
    func logout(completion: @escaping () -> ()) {
        api.logout(completion: completion)
    }
    
    func checkEmailForLogin(email: String, completion: @escaping (Bool) -> ()) {
        DispatchQueue.main.async {
            completion( email.count > 8 )
        }
    }
    
    func checkPasswordForLogin(email: String, password: String, completion: @escaping (Bool) -> ()) {
        DispatchQueue.main.async {
            completion( email.count > 8 && password.count > 8 )
        }
    }
}
