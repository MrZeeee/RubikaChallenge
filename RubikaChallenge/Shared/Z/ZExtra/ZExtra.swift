//
//  ZExtra.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 1/25/22.
//

import Foundation
import UIKit



class ZExtra: NSObject {
    
    public func share(items: [Any], on controller: UIViewController? = Z.ui.rootController, with frame: CGRect = .zero) {
        let activityViewController = UIActivityViewController(activityItems: items , applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop]
        activityViewController.popoverPresentationController?.sourceView = controller?.view
        activityViewController.popoverPresentationController?.sourceRect = frame
        controller?.present(activityViewController, animated: true, completion: nil)
    }
    
}
