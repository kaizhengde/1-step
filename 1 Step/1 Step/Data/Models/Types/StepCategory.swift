//
//  StepCategory.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

@objc
enum StepCategory: Int16 {
    
    case duration   = 0
    case distance   = 1
    case reps       = 2
    
    
    var describtion: String {
        switch self {
        case .duration: return "duration"
        case .distance: return "distance"
        case .reps:     return "reps"
        }
    }
}
