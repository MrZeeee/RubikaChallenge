//
//  Extension + UITabBarController.swift
//  Unite
//
//  Created by Mr Zee on 2/15/21.
//

import Foundation
import UIKit


extension UITabBar {
    
    
    static var tabBarHeight: CGFloat {
        return UITabBarController.init(nibName: nil, bundle: nil).tabBar.frame.size.height;
    }
    
}
