//
//  Animation+Delay.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI

enum AnimationDuration {
    
    static let opacity: Double          = 0.3
    static let halfOpacity: Double      = opacity/2.0
    static let mountainAppear: Double   = 0.8
    static let mountainDismiss: Double  = 0.6
}

enum DelayAfter {
    
    static let none: DispatchTimeInterval = .milliseconds(0)
    static let opacity: DispatchTimeInterval = .milliseconds(Int(AnimationDuration.opacity*1000))
    static let halfOpacity: DispatchTimeInterval = .milliseconds(Int(AnimationDuration.halfOpacity*1000))
    static let mountainAppear: DispatchTimeInterval = .milliseconds(Int(AnimationDuration.mountainAppear*1000))
    static let mountainDismiss: DispatchTimeInterval = .milliseconds(Int(AnimationDuration.mountainDismiss*1000))
}

extension Animation {
    
    enum Duration {
        
        static let oneS: Double             = 0.6
        static let opacity: Double          = 0.3
        static let halfOpacity: Double      = opacity/2.0
        static let mountainAppear: Double   = 0.8
        static let mountainDismiss: Double  = 0.6
    }
    
    enum Delay {
        
        static let oneS: DispatchTimeInterval             = .milliseconds(Int(Duration.oneS*1000))
        static let opacity: DispatchTimeInterval          = .milliseconds(Int(Duration.opacity*1000))
        static let halfOpacity: DispatchTimeInterval      = .milliseconds(Int(Duration.halfOpacity*1000))
        static let mountainAppear: DispatchTimeInterval   = .milliseconds(Int(Duration.mountainAppear*1000))
        static let mountainDismiss: DispatchTimeInterval  = .milliseconds(Int(Duration.mountainDismiss*1000))
    }
}
