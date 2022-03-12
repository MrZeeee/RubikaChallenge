//
//  Feature.vc.header.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import UIKit



extension Feature.vc {
    
    class header: ZTableViewHeaderFooter {
        
        private var titleLabel: UILabel!
        
        override func initialize() {
            super.initialize()
            self.ui()
        }
        
        // MARK: - FUNCTIONS
        private func ui() {
            self.contentView.backgroundColor = .white
            
            titleLabel = UILabel()
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.font = .boldSystemFont(ofSize: 18)
            self.contentView.addSubview(titleLabel)
            titleLabel.constrain(to: self.contentView).leadingTrailingTopBottom(constant: AppConstant.k.margin)
            
        }
        
        public func configure(title: String) {
            self.titleLabel.text = title
        }
        
    }
    
}
