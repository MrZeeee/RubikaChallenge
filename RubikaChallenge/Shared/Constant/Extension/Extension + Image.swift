//
//  Extension + Image.swift
//  DrYab
//
//  Created by Mr Zee on 12/12/20.
//

import Foundation
import UIKit


extension UIImage {
    
    
    enum app: String {
        
        public var value: UIImage? {
            return UIImage(named: self.rawValue)
        }
        
        // MARK: - ICONS
        case check
        case uncheck
        
    }
    
    
}
