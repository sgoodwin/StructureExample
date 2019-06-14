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
}

struct FakeAPI: API {
    func fetchCurrentUser(completion: @escaping (User?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(
                User(
                    username: "someone@aol.com",
                    password: "xxxxxxxx",
                    photoData: UIImage(named: "logo")!.pngData()!
                )
            )
        }
    }
}
