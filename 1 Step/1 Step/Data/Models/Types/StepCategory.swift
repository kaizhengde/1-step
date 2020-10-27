//
//  StepCategory.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

enum StepCategory {
    
    case duration
    case distance
    case reps
    
    
    var description: String {
        switch self {
        case .duration: return "duration"
        case .distance: return "distance"
        case .reps:     return "reps"
        }
    }
}
