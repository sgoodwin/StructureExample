//
//  AuthParentViewController.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

class AuthParentViewController: UIViewController {
    enum Status {
        case determining
        case loggedIn
        case loggedOut
    }
    
    var status: Status = .determining {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateChildForStatus()
            }
        }
    }
    
    lazy var authFlow: AuthFlow = {
        return AuthFlow()
    }()
    
    func updateChildForStatus() {
        if let controller = controllerFor(status: status) {
            UIView.animate(withDuration: 0.3) {
                self.embedFullViewChild(controller)
            }
        }
    }
    
    private func controllerFor(status: Status) -> UIViewController? {
        switch status {
        case .determining:
            return storyboard?.instantiateViewController(withIdentifier: "splash")
        case .loggedIn:
            return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        case .loggedOut:
            return authFlow.initialController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChildForStatus()
    }
}

extension UIViewController {
    func embedFullViewChild(_ controller: UIViewController) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        let newView = controller.view
        view.addSubview(newView!)
        newView?.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[newView]-(0)-|", options: [], metrics: nil, views: ["newView" : newView!]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[newView]-(0)-|", options: [], metrics: nil, views: ["newView" : newView!]))
        
        addChild(controller)
        controller.didMove(toParent: self)
    }
}
