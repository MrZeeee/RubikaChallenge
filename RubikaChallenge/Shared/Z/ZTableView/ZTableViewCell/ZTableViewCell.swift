//
//  ZTableViewCell.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 7/25/21.
//

import UIKit

fileprivate var reuseIdentifierKey = "reuseIdentifier"

class ZTableViewCell: UITableViewCell {
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// in order to use ZTableViewcell you should override this method
    open func initialize() {
        self.selectionStyle = .none
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
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
