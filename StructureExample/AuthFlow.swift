//
//  AuthFlow.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

struct AuthFlow {
    let storyboard = UIStoryboard(name: "Auth", bundle: nil)
    
    enum Stage {
        // An arbitrary reprentation of the user's flow.
        // Some steps may be skipped depending on what we know about the user.
        case email // user needs to enter an email
        case password // user needs to enter a password
        case setPassword // user is new and needs to set a password
        case setPhoto // user is new and needs to set a photo
        case done // user is ready to party
    }
    
    func initialController() -> UIViewController? {
        return storyboard.instantiateInitialViewController()
    }
}
