//
//  Keyboard.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI
import AudioToolbox

//MARK: - Haptic Feedback

enum Feedback {
    
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if Device.isiPhoneXType {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        } else {
            AudioServicesPlaySystemSound(1519)
        }
    }


    static func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
