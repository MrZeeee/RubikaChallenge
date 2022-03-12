//
//  Extension + UIImageView.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 11/26/21.
//

import Foundation
import UIKit


extension UIImageView {
    
    
    func loadGif(with name: String, duration: TimeInterval = 0.0, repeatCount: Int = 0) {
        guard let bundle = Bundle.main.url(forResource: name, withExtension: "gif") else { return }
        guard let data = try? Data.init(contentsOf: bundle) else { return }
        guard let source =  CGImageSourceCreateWithData(data as CFData, nil) else { return }
        let imageCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        for i in 0..<imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        self.animationImages = images
        self.animationDuration = duration
        self.animationRepeatCount = repeatCount
        self.startAnimating()
    }
    
    
}
