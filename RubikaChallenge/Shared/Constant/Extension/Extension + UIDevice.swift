//
//  Extension + UIDevice.swift
//  Servus
//
//  Created by Mr Zee on 11/23/20.
//

import Foundation
import UIKit


extension UIDevice {
    var hasBottomNotch: Bool {
        return Z.ui.window?.safeAreaInsets.bottom ?? 0 > 0
    }
    
    var hasTopNotch: Bool {
        return Z.ui.window?.safeAreaInsets.top ?? 0 > 20
    }
    
    var topNotch: CGFloat {
        return Z.ui.window?.safeAreaInsets.top ?? 0
    }
    
    var bottomNotch: CGFloat {
        return Z.ui.window?.safeAreaInsets.bottom ?? 0
    }
    
    var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = Z.ui.window
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}

