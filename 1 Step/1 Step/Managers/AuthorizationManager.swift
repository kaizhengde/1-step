//
//  AuthorizationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import Photos

enum AuthorizationManager {
    
    static func requestPhotoLibraryAuthorizationIfNeeded(completion: @escaping (Bool) -> ()) {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion(true)
            return
        }
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                completion(status == .authorized)
            }
        } else {
            PopupManager.shared.showTextPopup(.photoLibraryNoAccess, titleText: "Error", bodyText: "Please grant permission to access the photo library.", backgroundColor: .darkNeutralToNeutral)
            completion(false)
        }
    }
}
