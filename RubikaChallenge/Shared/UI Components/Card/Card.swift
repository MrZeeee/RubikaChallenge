//
//  Card.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import UIKit

fileprivate let shadowColor = AppConstant.k.shadowColor
fileprivate let shadowOffest = AppConstant.k.shadowOffset
fileprivate let shadowOpacity = AppConstant.k.shadowOpacity
fileprivate let shadowRadius = AppConstant.k.shadowRadius
fileprivate let margin = AppConstant.k.margin
fileprivate let cornerRadius = AppConstant.k.cornerRadius

class Card: UIView {

    private var shadow: UIView!
    public var contentView: UIView!
    
    private var inset: UIEdgeInsets
    
    init(inset: UIEdgeInsets = .init(top: 0, left: margin, bottom: 0, right: margin)) {
        self.inset = inset
        super.init(frame: .zero)
        self._initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func _initialize() {
        self.backgroundColor = .clear
        
        shadow = UIView()
        shadow.backgroundColor = .clear
        shadow.layer.cornerRadius = cornerRadius
        shadow.dropShadow(color: shadowColor, opacity: shadowOpacity, offset: shadowOffest, radius: shadowRadius)
        self.addSubview(shadow)
        shadow.constrain(to: self).leading(constant: self.inset.left).trailing(constant: self.inset.right).top(constant: self.inset.top).bottom(constant: self.inset.bottom)
        
        contentView = UIView()
        contentView.backgroundColor = .app.green.value
        contentView.layer.cornerRadius = cornerRadius
        contentView.clipsToBounds = true
        self.shadow.addSubview(contentView)
        contentView.constrain(to: self.shadow).leadingTrailingTopBottom()
        
        self.initialize(with: contentView)
        
    }
    
    public func initialize(with contentView: UIView) {
        
    }

}
