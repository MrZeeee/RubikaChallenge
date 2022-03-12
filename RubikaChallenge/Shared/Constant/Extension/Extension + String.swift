//
//  Extension + String.swift
//  DrYab
//
//  Created by Mr Zee on 12/12/20.
//

import Foundation
import UIKit


extension String {
    
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isFullname: Bool {
        let regex = ".{1,}"
        let fullnameTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return fullnameTest.evaluate(with: self)
    }
    
    var isMobile: Bool {
        let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return phoneCheck.evaluate(with: self)
    }
    
    var isPassword: Bool {
        let regex = ".{1,}"
        let fullnameTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return fullnameTest.evaluate(with: self)
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size
    }
    
    func generateQRCode() -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 1, y: 1)
            if let output = filter.outputImage?.transformed(by: transform) {
                let image = UIImage(ciImage: output)
                let size: CGSize = .init(width: 500, height: 500)
                UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
                image.draw(in: .init(origin: .zero, size: size))
                    let newImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                return newImage
            }
        }
        return nil
    }
    
    func name() -> (String?, String?) {
        let res = self.split(separator: " ")
        guard let name = res.first else { return (nil, nil) }
        guard let surname = res.last else { return (String(name), nil) }
        return (String(name), String(surname))
    }
    
    func time() -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: self)
        let returnFormatter = DateFormatter()
        returnFormatter.timeZone = .current
        returnFormatter.dateFormat = "HH:mm"
        if let d = date {
            return returnFormatter.string(from: d)
        }
        return nil
    }
    
    func udate() -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: self)
        let returnFormatter = DateFormatter()
        returnFormatter.timeZone = .current
        returnFormatter.dateFormat = "MM/dd/yyyy"
        if let d = date {
            return returnFormatter.string(from: d)
        }
        return nil
    }
    
    func descDate() -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: self)
        let returnFormatter = DateFormatter()
        returnFormatter.timeZone = .current
        returnFormatter.dateFormat = "dd MMM yyyy"
        if let d = date {
            return returnFormatter.string(from: d)
        }
        return nil
    }
    
    
    
}
