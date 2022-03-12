//
//  ZMath.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/11/21.
//

import Foundation
import UIKit


class ZMath: NSObject {
    
    public func lMapValue(value: CGFloat, srcLow: CGFloat, srcHigh: CGFloat, dstLow: CGFloat, dstHigh: CGFloat) -> CGFloat {
        var low = dstLow
        var high = dstHigh
        let negate = dstLow > dstHigh
        if negate {
            low = -low
            high = -high
        }
        let result = (low + (value - srcLow) * (high - low) / (srcHigh - srcLow))
        return (negate ? -1 : 1) * min(max(result, low), high)
    }
    
    public func fib(_ n: Int) -> Int {
        var (a, b) = (1, 1)
        guard n > 1 else { return a }
        (2...n).forEach { _ in (a, b) = (a + b, a) }
        return a
    }
    
}
