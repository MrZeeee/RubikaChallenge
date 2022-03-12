//
//  Loading.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/14/21.
//

import Foundation
import UIKit



class Loading: UIView {

    private var bg: UIView!
    private var indicator: UIActivityIndicatorView!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func initialize() {
        self.backgroundColor = .clear
        
        bg = UIView()
        bg.backgroundColor = UIColor.white
        bg.layer.cornerRadius = 12
        bg.dropShadow()
        self.addSubview(bg)
        bg.constrain(to: self).leadingTrailing(constant: 150).centerY()
        bg.constrainSelf().aspectRatio(1)
        
        indicator = UIActivityIndicatorView.init(style: .large)
        self.bg.addSubview(indicator)
        indicator.constrain(to: self.bg).centerXY()
        
        indicator.startAnimating()
    }
    
    public func stop() {
        indicator.stopAnimating()
    }
    
}

extension UIView {
    
    public func beginLoading() {
        if self.subviews.contains(where: {$0 is Loading}) { return }
        let loading = Loading()
        loading.alpha = 0
        self.insertSubview(loading, at: 0)
        self.bringSubviewToFront(loading)
        loading.constrain(to: self).leadingTrailingTopBottom()
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            guard let _ = self else { return }
            loading.alpha = 1
        })
    }
    
    public func endLoading() {
        var v = self.subviews.first(where: { $0 is Loading })
        if v == nil {
            let v1 = self.subviews.first(where: { view in
                return view.subviews.contains(where: { $0 is Loading })
            })
            v = v1?.subviews.first(where: { $0 is Loading })
        }
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            guard let _ = self else { return }
            v?.alpha = 0
            (v as? Loading)?.stop()
            }, completion: {[weak self] f in
                guard let _ = self else { return }
                v?.removeFromSuperview()
        })
    }
}
