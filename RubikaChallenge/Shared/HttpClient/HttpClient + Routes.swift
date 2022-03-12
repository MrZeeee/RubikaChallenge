//
//  HttpClient + Routes.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/11/22.
//

import Foundation



extension HttpClient {
    
    struct routes {
        
        enum base: RawRepresentable {
            typealias RawValue = String
            
            case host
            
            var rawValue: String {
                switch self {
                case .host: return "edapi.eddibike.com"
                }
            }
            
            init?(rawValue: Self.RawValue) {
                nil
            }
        }
        
        enum feature: RawRepresentable {
            typealias RawValue = String
            
            case list
            
            var rawValue: String {
                switch self {
                case .list: return ""
                }
            }
            
            init?(rawValue: Self.RawValue) {
                nil
            }
        }
        
    }
    
}
