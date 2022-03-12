//
//  ZNetwork + Error.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/11/22.
//

import Foundation



extension ZNetwork {
    
    struct error: Error {
        
        public var statusCode: Int
        public var response: URLResponse?
        public var description: String?
        
    }
    
}
