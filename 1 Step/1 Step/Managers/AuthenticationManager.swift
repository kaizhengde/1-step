//
//  AuthenticationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import Foundation
import LocalAuthentication
import Combine

enum AuthenticationManager {
    
    enum BiometricType {
        case none
        case touch
        case face
        
        var description: String? {
            switch self {
            case .none:     return nil
            case .touch:    return "TouchID"
            case .face:     return "FaceID"
            }
        }
    }
    
    
    static func getBiometricType() -> BiometricType {
        let _ = LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        switch LAContext().biometryType {
        case .none:         return .none
        case .touchID:      return .touch
        case .faceID:       return .face
        @unknown default:   fatalError()
        }
    }
    
    
    static func authorize(completion: @escaping (Bool) -> ()) {
        guard biometricAuthenticationIsPossible() else {
            completion(false)
            return
        }
        
        let reason = "To continue, you need to authorize yourself."

        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { valid, _ in
            DispatchQueue.main.async {
                if valid {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    
    static func requestPermissionForFaceTouchID(success: @escaping () -> ()) {
        guard biometricAuthenticationIsPossible() else { return }
        
        let reason = "To activate biometric authentication, we need to authorize you."

        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { valid, error in
            DispatchQueue.main.async {
                if error != nil {
                    PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                        OneSTextPopupView(titleText: "Error", bodyText: "Could not enable biometric authentication.")
                    }
                }
                
                if valid {
                    success()
                }
            }
        }
    }
    
    
    private static func biometricAuthenticationIsPossible() -> Bool {
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return true
        }
        
        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
            OneSTextPopupView(titleText: "Error", bodyText: "Biometric authentication failed. Make sure that you have your biometrics setup inside settings and turned on for 1 Step.")
        }
        return false
    }
}
