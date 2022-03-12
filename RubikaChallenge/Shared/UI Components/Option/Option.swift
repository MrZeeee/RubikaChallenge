//
//  Option.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/10/22.
//

import Foundation
import UIKit



class Option: UIView {
    
    private var titleLabel: UILabel!
    private var imageView: UIImageView!
    private var btn: UIButton!
    
    private(set) var title: String
    private var selected: Bool
    
    
    init(title: String, selected: Bool) {
        self.title = title
        self.selected = selected
        super.init(frame: .zero)
        self.ui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func ui() {
        self.layer.cornerRadius = AppConstant.k.cornerRadius
        self.backgroundColor = .app.darkGreen.value
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.text = self.title
        self.addSubview(titleLabel)
        titleLabel.constrain(to: self).leading(constant: AppConstant.k.margin).topBottom(constant: AppConstant.k.margin, priority: .defaultHigh)
        
        imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.image = selected ? .app.check.value : .app.uncheck.value
        self.addSubview(imageView)
        imageView.constrain(to: self).trailing(constant: AppConstant.k.lowMargin).topBottom(constant: AppConstant.k.lowMargin, priority: .defaultHigh).centerY()
        imageView.constrainSelf().aspectRatio(1).width(constant: AppConstant.k.margin * 2)
        
        btn = UIButton()
        btn.setImage(nil, for: .normal)
        btn.setTitle(nil, for: .normal)
        self.addSubview(btn)
        btn.constrain(to: self).leadingTrailingTopBottom()
        
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        btn.addTarget(target, action: action, for: controlEvents)
    }
    
    public func set(selected: Bool) {
        imageView.image = selected ? .app.check.value : .app.uncheck.value
    }
    
    
    
}
