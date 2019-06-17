//
//  AuthFlow.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

class AuthFlow {
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
    
    var stage: Stage {
        didSet {
            self.updateFor(stage: stage)
        }
    }
    
    let root: UINavigationController
    
    init(root: UINavigationController) {
        self.root = root
        self.stage = .email
        updateFor(stage: .email)
    }
    
    private func updateFor(stage: Stage) {
        guard let next = controllerForStage(self.stage) else { return }
        root.setViewControllers([next], animated: false)
    }
    
    private func controllerForStage(_ stage: Stage) -> UIViewController? {
        switch stage {
        case .email:
            let controller = storyboard.instantiateViewController(withIdentifier: "email") as! EmailViewController
            controller.delegate = self
            return controller
        case .password:
            let controller = storyboard.instantiateViewController(withIdentifier: "password") as! PasswordViewController
            controller.delegate = self
            return controller
        default:
            return nil // Don't worry about the other steps for now. Let's say signup isn't possible because we're lazy.
        }
    }
}

extension AuthFlow: EmailViewDelegate {
    func controllerDidReceieve(email: String) {
        stage = .password
    }
}

extension AuthFlow: PasswordViewDelegate {
    func controllerDidReceieve(password: String) {
        stage = .done
    }
}
