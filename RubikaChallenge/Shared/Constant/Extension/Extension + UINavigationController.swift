//
//  Extension + UINavigationController.swift
//  Servus
//
//  Created by Mr Zee on 11/23/20.
//

import Foundation
import UIKit

extension UINavigationController {
    
    static var navBarHeight: CGFloat {
        return UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil)).navigationBar.frame.size.height
    }
    
}
