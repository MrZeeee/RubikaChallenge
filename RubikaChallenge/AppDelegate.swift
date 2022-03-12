//
//  AppDelegate.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppConstant.instance._initialize()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        AppConstant.instance.initUI()
        
        return true
    }


}

