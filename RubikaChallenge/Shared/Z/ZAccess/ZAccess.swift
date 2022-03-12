//
//  ZAccess.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 11/26/21.
//

import Foundation
import AVFoundation
import Photos



class ZAccess: NSObject {
    
    
    func camera(type: AVMediaType = .video, completion: ((Bool) -> Void)? = nil) {
        let status = AVCaptureDevice.authorizationStatus(for: type)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: type, completionHandler: { success in
                completion?(success)
            })
        case .restricted:
            completion?(false)
        case .denied:
            completion?(false)
        case .authorized:
            completion?(true)
        @unknown default:
            completion?(false)
        }
    }
    
    func photos(completion: ((Bool) -> Void)? = nil) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                self.photos(completion: completion)
            })
        case .restricted:
            completion?(false)
        case .denied:
            completion?(false)
        case .authorized:
            completion?(true)
        case .limited:
            completion?(true)
        @unknown default:
            completion?(false)
        }
    }
    
}
