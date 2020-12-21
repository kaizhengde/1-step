//
//  Keyboard.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI
import AudioToolbox

struct OneSFeedback {
    
    static private let feedbackSupportLevel = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int
    
    static func heavy() {
        switch feedbackSupportLevel {
        case 2: UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case 1: AudioServicesPlaySystemSound(SystemSoundID(1520))
        default: break
        }
    }
    
    
    static func light() {
        switch feedbackSupportLevel {
        case 2: UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case 1: break
        default: break
        }
    }
    
    
    static func soft() {
        switch feedbackSupportLevel {
        case 2: UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case 1: break
        default: break
        }
    }
    
    
    static func achievement() {
        switch feedbackSupportLevel {
        case 2: UINotificationFeedbackGenerator().notificationOccurred(.success)
        case 1: AudioServicesPlaySystemSound(SystemSoundID(1102))
        default: break
        }
    }
    
    
    static func warning() {
        switch feedbackSupportLevel {
        case 2: UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        case 1: AudioServicesPlaySystemSound(SystemSoundID(1519))
        default: break
        }
    }
    
    
    static func failed() {
        switch feedbackSupportLevel {
        case 2: UINotificationFeedbackGenerator().notificationOccurred(.error)
        case 1: AudioServicesPlaySystemSound(SystemSoundID(1053))
        default: break
        }
    }
}
