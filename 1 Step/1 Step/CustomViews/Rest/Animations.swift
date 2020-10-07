//
//  Animation.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI

struct OneSAnimation: ViewModifier {
    
    var delay: Double
    
    
    func body(content: Content) -> some View {
        content
            .animation(Animation.timingCurve(0.3, 0.6, 0.2, 1, duration: 0.6).delay(delay))
    }
}


struct OneSOpacityAnimation: ViewModifier {
    
    var delay: Double = 0
    
    
    func body(content: Content) -> some View {
        content
            .animation(Animation.easeInOut(duration: AnimationDuration.screenOpacity).delay(delay))
    }
}


struct OneSMountainAnimation: ViewModifier {
    
    var response: Double
    var dampingFraction: Double
    
    
    func body(content: Content) -> some View {
        content
            .animation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: 0))
    }
}


extension View {
    
    func oneSAnimation(delay: Double = 0.0) -> some View {
        return modifier(OneSAnimation(delay: delay))
    }
    
    
    func oneSOpacityAnimation(delay: Double = 0.0) -> some View {
        return modifier(OneSOpacityAnimation(delay: delay))
    }
    
    
    func oneSMountainAnimation(response: Double = 0.8, dampingFraction: Double = 0.7) -> some View {
        return modifier(OneSMountainAnimation(response: response, dampingFraction: dampingFraction))
    }
}
