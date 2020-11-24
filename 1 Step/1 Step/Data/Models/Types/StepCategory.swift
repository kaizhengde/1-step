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
        case .duration: return Localized.Step.category_duration
        case .distance: return Localized.Step.category_distance
        case .reps:     return Localized.Step.category_reps
        }
    }
}
