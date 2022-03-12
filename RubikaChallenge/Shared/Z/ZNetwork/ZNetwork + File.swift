//
//  ZNetwork + File.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/21/21.
//

import Foundation


extension ZNetwork {
    
    struct file: Encodable {
        
        public var name: String
        public var file: Data
        public var mimeType: String
        
    }
    
}
