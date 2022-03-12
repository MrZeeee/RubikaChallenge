//
//  ZMeta.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 7/26/21.
//

import Foundation

fileprivate var defaultMetaKey = "ZMetaKey"

extension NSObject {
    
    
    public func set(meta: Any, for key: String) {
        var possibleDic = objc_getAssociatedObject(self, defaultMetaKey) as? Dictionary<String, Any>
        if possibleDic != nil {
            possibleDic![key] = meta
        } else {
            var dic: Dictionary<String, Any> = [:]
            dic[key] = meta
            objc_setAssociatedObject(self, defaultMetaKey, dic, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func set(meta: AnyObject) {
        self.set(meta: meta, for: defaultMetaKey)
    }
    
    public func meta(for key: String) -> AnyObject? {
        let dic = objc_getAssociatedObject(self, defaultMetaKey) as? Dictionary<String, AnyObject>
        return dic?[key]
    }
    
    public func meta() -> AnyObject? {
        self.meta(for: defaultMetaKey)
    }
    
    
}
