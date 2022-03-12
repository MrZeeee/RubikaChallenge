//
//  ZUI.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/11/21.
//

import Foundation
import UIKit


class ZUI {
    
    
    open func `switch`(window toVC: UIViewController, animated: Bool = true, completionHandler: ((Bool) -> Void)? = nil) {
        var window: UIWindow!
        if let w = UIApplication.shared.windows.filter(\.isKeyWindow).first {
            window = w
        }
        window.rootViewController = toVC
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: animated ? 0.3 : 0, options: .transitionCrossDissolve, animations: {}, completion: { completed in
            completionHandler?(completed)
        })
    }
    
    open var rootController: UIViewController? {
        get {
            if let window = UIApplication.shared.windows.filter(\.isKeyWindow).first {
                return window.rootViewController
            }
            return nil
        }
    }
    
    open var window: UIWindow? {
        get {
            var window: UIWindow?
            if let w = UIApplication.shared.windows.filter(\.isKeyWindow).first {
                window = w
            }
            return window
        }
    }
    
}
