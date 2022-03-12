//
//  request.base.swift
//  CodeChallenge
//
//  Created by MohammadReza Zamanieh on 3/4/22.
//

import Foundation



extension Model.request {
    
    struct feature: Codable {
        
        public var type: String?
        public var size: String?
        public var extras: [String]
    }
    
}
