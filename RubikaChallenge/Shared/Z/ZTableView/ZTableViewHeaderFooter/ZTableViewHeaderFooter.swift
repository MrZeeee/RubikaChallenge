//
//  ZTableViewHeaderFooter.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/10/21.
//

import UIKit

fileprivate var reuseIdentifierKey = "reuseIdentifier"

class ZTableViewHeaderFooter: UITableViewHeaderFooterView {
    
    private var bg: UIView!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initialize() {
        self.contentView.backgroundColor = .clear
        
        bg = UIView.init(frame: self.frame)
        bg.backgroundColor = .clear
        self.backgroundView = self.bg
        
    }
    
    public static func reuseIdentifier() -> String {
        var id = self.init().meta(for: reuseIdentifierKey) as? String
        if id == nil {
            id = NSStringFromClass(Self.self)
            self.init().set(meta: id!, for: reuseIdentifierKey)
        }
        return id!
    }
    
}
