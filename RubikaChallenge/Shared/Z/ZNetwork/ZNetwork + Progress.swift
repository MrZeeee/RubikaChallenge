//
//  ZNetwork + Progress.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/21/21.
//

import Foundation


extension ZNetwork {
    
    struct progress: Decodable {
        
        public var progress: Double
        public var estimatedTime: TimeInterval
        public var total: Int64
        public var current: Int64
    }
    
}
