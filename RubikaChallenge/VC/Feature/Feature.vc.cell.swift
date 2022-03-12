//
//  Feature.vc.cell.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import UIKit

protocol FeatureVCCellDelegate: NSObject {
    
    func cell(_ cell: Feature.vc.cell, didSelect sub: String)
    
    func cell(_ cell: Feature.vc.cell, didDeselect sub: String)
    
}

extension Feature.vc {
    
    class cell: ZTableViewCell {
        
        private var card: Card!
        private var vst: UIStackView!
        private var item: Item!
        private var sep: UIView!
        private var subST: UIStackView!
        
        private var subs: [String] = []
        private var selectedSub: String?
        
        public weak var delegate: FeatureVCCellDelegate?
        
        
        override func initialize() {
            super.initialize()
            self.ui()
        }
        
        // MARK: - FUNCTIONS
        private func ui() {
            
            card = Card()
            self.contentView.addSubview(card)
            card.constrain(to: self.contentView).leadingTrailing().top(constant: AppConstant.k.margin).bottom()
            
            vst = UIStackView()
            vst.axis = .vertical
            vst.alignment = .fill
            vst.distribution = .equalSpacing
            vst.spacing = AppConstant.k.lowMargin
            self.card.contentView.addSubview(vst)
            vst.constrain(to: self.card.contentView).leadingTrailingTopBottom(constant: AppConstant.k.margin)
            
            item = Item.init(canEdit: false)
            self.vst.addArrangedSubview(item)
            
            sep = UIView()
            sep.backgroundColor = .white
            sep.isHidden = true
            self.vst.addArrangedSubview(sep)
            sep.constrainSelf().height(constant: 1)
            
            subST = UIStackView()
            subST.axis = .vertical
            subST.alignment = .fill
            subST.distribution = .fillEqually
            subST.spacing = AppConstant.k.lowMargin
            subST.isHidden = true
            self.vst.addArrangedSubview(subST)
            
            
        }
        
        private func reload(subs: [String], selected: String?) {
            self.subs = subs
            self.selectedSub = selected
            for view in self.subST.arrangedSubviews {
                if let v = view as? Option {
                    self.subST.removeArrangedSubview(v)
                }
            }
            for sub in subs {
                let option = Option.init(title: sub, selected: sub == selected)
                option.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
                self.subST.addArrangedSubview(option)
            }
            
        }
        
        @objc private func optionTapped(_ sender: UIButton) {
            guard let opt = sender.superview as? Option else { return }
            if opt.title == selectedSub {
                self.selectedSub = nil
                delegate?.cell(self, didDeselect: opt.title)
                opt.set(selected: false)
            } else {
                for view in self.subST.arrangedSubviews {
                    if let v = view as? Option {
                        v.set(selected: false)
                        delegate?.cell(self, didDeselect: v.title)
                    }
                }
                self.selectedSub = opt.title
                opt.set(selected: true)
                delegate?.cell(self, didSelect: opt.title)
            }
        }
        
        public func toggleExpand(animated: Bool = true) {
            guard !self.subs.isEmpty else { return }
            let isHidden = self.subST.isHidden
            UIView.animate(withDuration: animated ? 0.3 : 0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.sep.alpha = isHidden ? 1 : 0
                self.subST.alpha = isHidden ? 1 : 0
                self.sep.isHidden.toggle()
                self.subST.isHidden.toggle()
            })
        }
        
        public func configure(image: UIImage?, name: String, subs: [String], selected: String? = nil) {
            self.item.configure(with: image, title: name)
            self.reload(subs: subs, selected: selected)
        }
        
    }
    
}
