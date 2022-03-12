//
//  ErrorView.swift
//  Servus
//
//  Created by Mr Zee on 1/26/21.
//

import UIKit
import SwiftMessages

extension UIViewController {
    
    
    public func handle(err: Error) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.titleLabel?.isHidden = true
        view.iconLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        let e = err as NSError
        view.bodyLabel?.text = e.domain
        switch e.code {
        case 200..<300:
            view.configureTheme(.success)
        case 300..<400:
            view.configureTheme(.warning)
        default:
            view.configureTheme(.error)
        }
        var config = SwiftMessages.Config()
        config.duration = SwiftMessages.Duration.seconds(seconds: 3)
        config.ignoreDuplicates = true
        config.interactiveHide = true
        config.presentationStyle = .top
        config.shouldAutorotate = true
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: view)
        }
    }
}
