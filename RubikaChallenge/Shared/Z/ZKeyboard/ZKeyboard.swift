//
//  ZKeyboard.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/14/21.
//

import Foundation
import UIKit


protocol ZKeyboardDelegate: NSObject {
    
    func keyboard(_ vc: UIViewController, willShowWith attributes: ZKeyboard.attributes)
    func keyboard(_ vc: UIViewController, willHideWith attributes: ZKeyboard.attributes)
}


struct ZKeyboard {
    
    struct attributes: Codable {
        
        var animationDuration: Double
        var curve: Int
        var frame: CGRect
        
    }
}
