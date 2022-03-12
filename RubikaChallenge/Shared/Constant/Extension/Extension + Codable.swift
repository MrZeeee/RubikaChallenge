//
//  Extension + Codable.swift
//  Servus
//
//  Created by Mr Zee on 1/10/21.
//

import Foundation


extension Encodable {
    
  func asDictionary() throws -> [String : Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
    
}
