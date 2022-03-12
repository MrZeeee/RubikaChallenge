//
//  ZUtilities.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/15/21.
//

import Foundation


class ZUtils: NSObject {
    
    
    public func configure<T: Any>(debug: T, release: T) -> T {
        #if DEBUG
        return debug
        #else
        return release
        #endif
    }
    
    
}
