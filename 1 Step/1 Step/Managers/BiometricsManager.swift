//
//  BiometricsManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import Foundation
import LocalAuthentication
import Combine

enum BiometricsManager {
    
    enum BiometricType {
        case none
        case touch
        case face
        
        var description: String? {
            switch self {
            case .none:     return nil
            case .touch:    return Localized.touchID
            case .face:     return Localized.faceID
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
    
    
    static func authorize(unavailable: @escaping () -> () = {}, completion: @escaping (Bool) -> ()) {
        guard biometricAuthenticationIsAvailable() else {
            unavailable()
            return
        }
        
        let reason = Localized.Biometrics.reason_authorizing

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
    
    
    static func requestPermission(success: @escaping () -> ()) {
        guard biometricAuthenticationIsAvailable() else { return }
        
        let reason = Localized.Biometrics.reason_requestPermission

        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { valid, error in
            DispatchQueue.main.async {
                if error != nil {
                    PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                        OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Biometrics.error_invalid)
                    }
                }
                
                if valid {
                    success()
                }
            }
        }
    }
    
    
    private static func biometricAuthenticationIsAvailable() -> Bool {
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return true
        }
        
        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
            OneSTextPopupView(titleText: Localized.error, bodyText: "\(BiometricsManager.getBiometricType().description!) \(Localized.Biometrics.error_unavailable)")
        }
        return false
    }
}
