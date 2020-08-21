//
//  AppDelegate.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 18.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        reloadApp()
        // Override point for customization after application launch.
        return true
    }

    func isUserLoggedIn() ->UIViewController {
        if !UserDefaults.standard.bool(forKey: "isUserLoggedIn"){
            return loginViewController()
        }else{
            return ContainerViewController()
        }
    }
    
    func reloadApp(){
        let VC = UINavigationController(rootViewController: isUserLoggedIn())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
        
    }


}

