//
//  AppDelegate.swift
//  StructureExample
//
//  Created by Samuel Goodwin on 6/14/19.
//  Copyright © 2019 Samuel Goodwin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let userManager = UserManager(api: FakeAPI())


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let controller = window?.rootViewController as! AuthParentViewController
        controller.userManager = userManager
        
        return true
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        userManager.logout { [weak self] in
            let controller = self?.window?.rootViewController as! AuthParentViewController
            controller.status = .loggedOut
        }
    }
}

