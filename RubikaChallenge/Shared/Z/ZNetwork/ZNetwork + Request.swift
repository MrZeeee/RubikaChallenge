//
//  ZNetwork + Request.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/15/21.
//

import Foundation


extension ZNetwork {
    
    struct request<T: Encodable> {
        
        var path: URL
        var method: HTTPMethod
        var body: T? = nil
        var headers: [String: String]? = nil
        var option: options = .init()
        
        func create() -> URLRequest {
            var request = URLRequest.init(url: path)
            request.allHTTPHeaderFields = headers
            request.httpMethod = method.rawValue
            if let b = body, let data = try? JSONEncoder().encode(b) {
                request.httpBody = data
            }
            return request
        }
        
    }
    
}
