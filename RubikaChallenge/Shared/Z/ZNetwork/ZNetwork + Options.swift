//
//  ZNetwork + Options.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/11/21.
//

import Foundation


extension ZNetwork {
    
    struct options {
        
        var timeoutInterval: TimeInterval = 100.0
        var shouldRetry: Bool = true
        var retryCount: Int = 22 // its more than one day for delay
        var currentRetry: Int = 0
        var retryDelayInterval: TimeInterval = 0.0
        var otherStatusCodesToSkipRetry: [Int] = [401, 403, 500]
        
        
    }
    
    
}
