//
//  Base.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/11/21.
//

import Foundation

extension Model.response {
    
    
    
    struct base: Codable {
        
        var _id: String
        var types: [type]
        var sizes: [size]
        var extras: [extra]
        
    }
    
    struct type: Codable {
        
        var _id: String
        var name: String
        var sizes: [String]
        var extras: [String]
        
    }
    
    struct size: Codable {
        
        var _id: String
        var name: String
        
    }
    
    struct extra: Codable, Hashable {
        
        static func == (lhs: Model.response.extra, rhs: Model.response.extra) -> Bool {
            return lhs._id == rhs._id
        }
        
        var _id: String
        var name: String
        var subselections: [sub]
        
        struct sub: Codable, Hashable {
            
            static func == (lhs: Model.response.extra.sub, rhs: Model.response.extra.sub) -> Bool {
                return lhs._id == rhs._id
            }
            
            var _id: String
            var name: String
            
        }
    }
    
}


