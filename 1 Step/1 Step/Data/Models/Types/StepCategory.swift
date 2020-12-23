//
//  StepCategory.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

enum StepCategory: Int16 {
    
    case duration   = 0
    case distance   = 1
    case reps       = 2
    
    
    var description: String {
        switch self {
        case .duration: return Localized.Step.category_duration
        case .distance: return Localized.Step.category_distance
        case .reps:     return Localized.Step.category_reps
        }
    }
}
