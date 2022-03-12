//
//  ZDate.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 9/27/21.
//

import Foundation


private let zFormat: String = "yyyy-MM-ddThh:mm:ss"
class ZDate: NSObject {
    
    
    public func iso_date(from iso_str: String, with options: ISO8601DateFormatter.Options = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = options
        return formatter.date(from: iso_str)
    }
    
    public func iso_str(from iso_date: Date, with options: ISO8601DateFormatter.Options = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = options
        return formatter.string(from: iso_date)
    }
    
    public func str(from date: Date, with format: String = zFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public func date(from str: String, with format: String = zFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: str)
    }
    
}
