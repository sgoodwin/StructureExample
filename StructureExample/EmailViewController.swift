//
//  EmailViewController.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/17/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

protocol EmailViewDelegate: class {
    func controllerDidReceieve(email: String)
}

class EmailViewController: UIViewController {
    weak var delegate: EmailViewDelegate?
    
    @IBAction func submit(sender: UITextField) {
        // Pretend we login by verifying email address as they type. Right now just make it long enough.
        if let text = sender.text, text.count > 8 {
            delegate?.controllerDidReceieve(email: text)
        }
    }
}

protocol PasswordViewDelegate: class {
    func controllerDidReceieve(password: String)
}

class PasswordViewController: UIViewController {
    weak var delegate: PasswordViewDelegate?
    
    @IBAction func submit(sender: UITextField) {
        // Pretend we login by verifying password as they type. Right now just make it long enough.
        if let text = sender.text, text.count > 8 {
            delegate?.controllerDidReceieve(password: text)
        }
    }
}
