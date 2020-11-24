//
//  Animation.swift
//  1 Step
//
//  Created by Kai Zheng on 07.10.20.
//

import SwiftUI

extension Animation {
    
    static func oneSAnimation(duration: Double = Duration.oneS, delay: Double = 0.0) -> Animation {
        return Animation.timingCurve(0.3, 0.6, 0.2, 1, duration: duration).delay(delay)
    }
    
    
    static func oneSOpacityAnimation(duration: Double = Animation.Duration.opacity, delay: Double = 0.0) -> Animation {
        return Animation.easeInOut(duration: duration).delay(delay)
    }
    
    
    static func oneSMountainAnimation(response: Double = 0.8, dampingFraction: Double = 0.7, delay: Double = 0.0) -> Animation {
        return Animation.spring(response: response, dampingFraction: dampingFraction, blendDuration: 0).delay(delay)
    }
}


extension View {
    
    func oneSAnimation(duration: Double = Animation.Duration.oneS, delay: Double = 0.0) -> some View {
        return animation(.oneSAnimation(duration: duration, delay: delay))
    }
    
    
    func oneSOpacityAnimation(duration: Double = Animation.Duration.opacity, delay: Double = 0.0) -> some View {
        return animation(.oneSOpacityAnimation(duration: duration, delay: delay))
    }
    
    
    func oneSMountainAnimation(response: Double = 0.8, dampingFraction: Double = 0.7, delay: Double = 0.0) -> some View {
        return animation(.oneSMountainAnimation(response: response, dampingFraction: dampingFraction, delay: delay))
    }
}
