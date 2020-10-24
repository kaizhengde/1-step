//
//  GoalStepsUnit.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

enum StepUnit: Equatable {
        
    //Duration
    case hours
    case min
    
    //Distance
    case km
    case m
    case miles
    case feets
    
    //Reps
    case times
    case pages
    case steps
    case decisions
    case trees
    case books
    
    case custom(String)
    
    
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
        case let .custom(text):
            return text.isEmpty ? "" : text
        }
    }
    
    
    var isCustom: Bool {
        switch self {
        case .custom(_):    return true
        default:            return false
        }
    }
    
    
    static func unitsOfCategory(_ category: StepCategory) -> [StepUnit] {
        switch category {
        case .duration: return [.hours, .min]
        case .distance: return [.km, .m, .miles, .feets]
        case .reps: return [.times, .pages, .steps, .decisions, .trees, .books, .custom("")]
        }
    }
    
    
    static func stepUnitFrom(description: String) -> Self {
        switch description {
        case "hours":       return .hours
        case "min":         return .min
        case "km":          return .km
        case "m":           return .m
        case "miles":       return .miles
        case "feets":       return .feets
        case "times":       return .times
        case "pages":       return .pages
        case "steps":       return .steps
        case "decisions":   return .decisions
        case "trees":       return .trees
        case "books":       return .books
        default:            return .custom(description)
        }
    }
    
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.custom(_), .custom(_)): return true
        default: return lhs.description == rhs.description
        }
    }
}
