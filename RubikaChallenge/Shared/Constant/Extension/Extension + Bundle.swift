//
//  Extension + Bundle.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 11/22/21.
//

import Foundation


extension Bundle {
    
    var release_version: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var build_version: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
