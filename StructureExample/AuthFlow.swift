//
//  AuthFlow.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

protocol AuthFlowDelegate: class {
    func flowDidFinish(_ flow: AuthFlow)
}

class AuthFlow {
    let storyboard = UIStoryboard(name: "Auth", bundle: nil)
    
    enum Stage: Equatable {
        // An arbitrary reprentation of the user's flow.
        // Some steps may be skipped depending on what we know about the user.
        case email // user needs to enter an email
        case password(enteredEmail: String) // user needs to enter a password
        case setPassword // user is new and needs to set a password
        case setPhoto // user is new and needs to set a photo
        case done // user is ready to party
    }
    
    var stage: Stage {
        didSet {
            self.updateFor(stage: stage)
            if stage == .done {
                self.delegate?.flowDidFinish(self)
            }
        }
    }
    
    let root: UINavigationController
    let userManager: UserManager
    weak var delegate: AuthFlowDelegate?
    
    init(root: UINavigationController, userManager: UserManager, delegate: AuthFlowDelegate?) {
        self.root = root
        self.userManager = userManager
        self.delegate = delegate
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
        userManager.checkEmailForLogin(email: email) { (success) in
            if success {
                self.stage = .password(enteredEmail: email)
            }
        }
    }
}

extension AuthFlow: PasswordViewDelegate {
    func controllerDidReceieve(password: String) {
        guard case .password(let enteredEmail) = stage else {
            return
        }
        
        userManager.checkPasswordForLogin(email: enteredEmail, password: password) { (success) in
            if success {
                self.stage = .done
            }
        }
    }
}
