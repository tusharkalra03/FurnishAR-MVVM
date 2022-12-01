//
//  CameraService.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CameraService: NSObject {
    
    static let instance = CameraService()
     
    var isPermissionGranted: Bool = false
    
    private override init(){}

    //MARK: Camera functions
     func checkAuthorizationStatus(cameraDevice: UIImagePickerController.CameraDevice) -> Bool{
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined: return requestCameraPermission()
        case .authorized: return true
        case .restricted, .denied: return false
        @unknown default: return false
        }
    }
    
     func isCameraAvailable() -> Bool {
        
        guard UIImagePickerController.isCameraDeviceAvailable(.rear) else {
            return false
        }
        
        guard let media = UIImagePickerController.availableMediaTypes(for: .camera) else {
            return false
        }
        
        return media.contains(kUTTypeMovie as String)
    }
    
    private func requestCameraPermission() -> Bool{
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
            self.isPermissionGranted = accessGranted
        })
        return isPermissionGranted
        
    }
}
