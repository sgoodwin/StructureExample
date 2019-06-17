//
//  FakeAPI.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

protocol API {
    func fetchCurrentUser(completion: @escaping (User?) -> ())
    func logout(completion: @escaping () -> ())
}

class FakeAPI: API {
    var user: User? = User(
        username: "someone@aol.com",
        password: "xxxxxxxx",
        photoData: UIImage(named: "logo")!.pngData()!
    )
    
    func fetchCurrentUser(completion: @escaping (User?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            completion(self?.user)
        }
    }
    
    func logout(completion: @escaping () -> ()) {
        self.user = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion()
        }
    }
}
