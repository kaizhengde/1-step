//
//  AuthorizationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import Photos
import LocalAuthentication

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
            PopupManager.shared.showPopup(.photoLibraryNoAccess, backgroundColor: .darkNeutralToNeutral) {
                OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Error.noAccessPhotoLibrary)
            }
            
            completion(false)
        }
    }
    
    
    static func requestFaceTouchIDAuthorization(success: @escaping () -> ()) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { valid, _ in
                DispatchQueue.main.async {
                    if valid {
                        success()
                        return
                    }
                }
            }
        }
    }
}
