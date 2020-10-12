//
//  GoalStepsUnit.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

@objc
enum StepUnit: Int16 {
        
    //Duration
    case hours      = 0
    case min        = 1
    
    //Distance
    case km         = 2
    case m          = 3
    case miles      = 4
    case feets      = 5
    
    //Reps
    case times      = 6
    case pages      = 7
    case steps      = 8
    case decisions  = 9
    case trees  = 10
    case books      = 11
    
    case custom     = 12
    
    
    var description: String {
        switch self {
        case .hours:        return "hours"
        case .min:          return "min"
        case .km:           return "km"
        case .m:            return "m"
        case .miles:        return "miles"
        case .feets:        return "feets"
        case .times:        return "times"
        case .pages:        return "pages"
        case .steps:        return "steps"
        case .decisions:    return "decisions"
        case .trees:        return "trees"
        case .books:        return "books"
        case .custom:       return "custom"
        }
    }
    
    
    static func unitsOfCategory(_ category: StepCategory) -> [StepUnit] {
        switch category {
        case .duration: return [.hours, .min]
        case .distance: return [.km, .m, .miles, .feets]
        case .reps: return [.times, .pages, .steps, .decisions, .trees, .books, .custom]
        }
    }
}
