//
//  Item.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/10/22.
//

import Foundation
import UIKit



class Item: UIView {
    
    private var st: UIStackView!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var editBtn: UIButton!
    public var type: Feature.type?
    
    private var canEdit: Bool
    
    init(canEdit: Bool) {
        self.canEdit = canEdit
        super.init(frame: .zero)
        self.ui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func ui() {
        
        st = UIStackView()
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fill
        st.spacing = AppConstant.k.lowMargin
        self.addSubview(st)
        st.constrain(to: self).leadingTrailing(constant: AppConstant.k.lowMargin).topBottom()
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.st.addArrangedSubview(imageView)
        imageView.constrainSelf().height(constant: AppConstant.k.margin * 3, priority: .defaultHigh)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 14)
        self.st.addArrangedSubview(titleLabel)
        
        guard canEdit else { return }
        
        editBtn = UIButton()
        editBtn.setTitle("Edit", for: .normal)
        editBtn.setTitleColor(.white, for: .normal)
        editBtn.setImage(nil, for: .normal)
        editBtn.titleLabel?.font = .systemFont(ofSize: 12)
        editBtn.contentHorizontalAlignment = .trailing
        self.addSubview(editBtn)
        editBtn.constrain(to: self).leadingTrailing(constant: AppConstant.k.margin).topBottom()
        
        
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        self.editBtn.addTarget(target, action: action, for: controlEvent)
    }
    
    public func configure(with image: UIImage?, title: String, type: Feature.type? = nil) {
        self.imageView.isHidden = image == nil
        self.imageView.image = image
        self.titleLabel.text = title
        self.type = type
    }
    
    
    
}
