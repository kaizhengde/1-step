//
//  Animation+Delay.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import Foundation

enum AnimationDuration {
    
    static let screenOpacity: Double = 0.4
    static let halfScreenOpacity: Double = screenOpacity/2.0
    static let mountainAppear: Double = 0.8
    static let mountainDismiss: Double = 0.6
}


enum DelayAfter {
    
    static var none: DispatchTime { .now() + .zero }
    static var halfScreenOpacity: DispatchTime { .now() + AnimationDuration.halfScreenOpacity }
    static var screenOpacity: DispatchTime { .now() + AnimationDuration.screenOpacity }
    static var mountainAppear: DispatchTime { .now() + AnimationDuration.mountainAppear }
    static var mountainDismiss: DispatchTime { .now() + AnimationDuration.mountainDismiss }
}
