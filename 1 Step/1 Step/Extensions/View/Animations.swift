//
//  Animation.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI

struct OneSAnimation: ViewModifier {
    
    var duration: Double
    var delay: Double
    
    
    func body(content: Content) -> some View {
        content
            .animation(Animation.timingCurve(0.3, 0.6, 0.2, 1, duration: duration).delay(delay))
    }
}


struct OneSOpacityAnimation: ViewModifier {
    
    var duration: Double
    var delay: Double
    
    
    func body(content: Content) -> some View {
        content
            .animation(Animation.easeInOut(duration: duration).delay(delay))
    }
}


struct OneSMountainAnimation: ViewModifier {
    
    var response: Double
    var dampingFraction: Double
    var delay: Double
    
    
    func body(content: Content) -> some View {
        content
            .animation(Animation.spring(response: response, dampingFraction: dampingFraction, blendDuration: 0).delay(delay))
    }
}


extension View {
    
    func oneSAnimation(duration: Double = 0.6, delay: Double = 0.0) -> some View {
        return modifier(OneSAnimation(duration: duration, delay: delay))
    }
    
    
    func oneSOpacityAnimation(duration: Double = AnimationDuration.opacity, delay: Double = 0.0) -> some View {
        return modifier(OneSOpacityAnimation(duration: duration, delay: delay))
    }
    
    
    func oneSMountainAnimation(response: Double = 0.8, dampingFraction: Double = 0.7, delay: Double = 0.0) -> some View {
        return modifier(OneSMountainAnimation(response: response, dampingFraction: dampingFraction, delay: delay))
    }
}


extension Animation {
    
    static func oneSAnimation(duration: Double = 0.6, delay: Double = 0.0) -> Animation {
        return Animation.timingCurve(0.3, 0.6, 0.2, 1, duration: duration).delay(delay)
    }
    
    
    static func oneSOpacityAnimation(duration: Double = AnimationDuration.opacity, delay: Double = 0.0) -> Animation {
        return Animation.easeInOut(duration: duration).delay(delay)
    }
    
    
    static func oneSMountainAnimation(response: Double = 0.8, dampingFraction: Double = 0.7, delay: Double = 0.0) -> Animation {
        return Animation.spring(response: response, dampingFraction: dampingFraction, blendDuration: 0).delay(delay)
    }
}
