//
//  Extension + UIViewController.swift
//  Unite
//
//  Created by Adib Dehghan on 2/8/21.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftAutoLayout

extension UIViewController {
    
        
    func addChildVC(containerView: UIView,_ controller: UIViewController, animated: Bool = true) {
        controller.view.alpha = 0
        controller.willMove(toParent: self)
        self.addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.constrain(to: containerView).leadingTrailingTopBottom()
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            controller.view.alpha = 1
        })
    }
    
    func removeChildVC(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        vc.willMove(toParent: nil)
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            vc.view.alpha = 0
        }, completion: { _ in
            vc.removeFromParent()
            vc.view.removeFromSuperview()
            vc.didMove(toParent: nil)
            completion?()
        })
    }
   
}
