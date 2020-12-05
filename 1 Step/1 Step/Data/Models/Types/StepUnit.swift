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
    case trees      = 10
    case books      = 11
    
    case custom     = 12
    case none       = 13
    
    
    var isCustom: Bool { self == .custom }
    
    
    //MARK: - Description
    
    var description: String {
        switch self {
        case .hours:        return Localized.Step.unit_h
        case .min:          return Localized.Step.unit_min
        case .km:           return Localized.Step.unit_km
        case .m:            return Localized.Step.unit_m
        case .miles:        return Localized.Step.unit_miles
        case .feets:        return Localized.Step.unit_feets
        case .times:        return Localized.Step.unit_times
        case .pages:        return Localized.Step.unit_pages
        case .steps:        return Localized.Step.unit_steps
        case .decisions:    return Localized.Step.unit_decisions
        case .trees:        return Localized.Step.unit_trees
        case .books:        return Localized.Step.unit_books
        case .custom:       return Localized.Step.unit_custom
        case .none:         return ""
        }
    }
    
    
    //MARK: - DualUnit
    
    var isDual: Bool {
        switch self {
        case .hours, .km, .miles:
            return true
        default:
            return false
        }
    }
    
    var dualUnit: Self? {
        guard self.isDual else { return nil }
        
        switch self {
        case .hours:    return .min
        case .km:       return .m
        case .miles:    return StepUnit.none
        default:        return nil
        }
    }
    
    var dualRatio: Double {
        guard self.isDual else { return 1 }
        
        switch self {
        case .hours:    return 60
        case .km:       return 1000
        case .miles:    return 1
        default:        return 0
        }
    }
    
    
    func translateMultiplier(to unit: Self) -> Double {
        if unit.isDual && unit != self {
            return 1/unit.dualRatio
        } else if self.isDual && unit != self {
            return self.dualRatio
        }
        return 1
    }
    
    
    //MARK: - Ratio
    
    func getRatio(from neededStepUnits: Int16) -> Int16 {
        
        guard self.isDual else { return 1 }
        
        switch self {
        case .hours:
            switch neededStepUnits {
            case 400...1000:    return 1    //Steps: [400 -> 1000]      1 Step = 1 Hour
            case 200...399:     return 2    //Steps: [400 -> 798]       1 Step = 30 Minutes
            case 90...199:      return 3    //Steps: [270 -> 597]       1 Step = 20 Minutes
            case 60...89:       return 4    //Steps: [240 -> 356]       1 Step = 15 Minutes
            case 30...59:       return 6    //Steps: [180 -> 354]       1 Step = 10 Minutes
            case 15...29:       return 10   //Steps: [150 -> 297]       1 Step = 6 Minutes
            case 8...14:        return 20   //Steps: [160 -> 280]       1 Step = 3 Minutes
            case 4...7:         return 30   //Steps: [120 -> 210]       1 Step = 2 Minutes
            case 1...3:         return 60   //Steps: [60 -> 180]        1 Step = 1 Minute
            default: break
            }
        case .km, .miles:
            switch neededStepUnits {
            case 400...1000:    return 1    //Steps: [400 -> 1000]      1 Step = 1 Kilometer    1 Mile
            case 200...399:     return 2    //Steps: [400 -> 798]       1 Step = 500 Meters     0.5 Mile
            case 100...199:     return 4    //Steps: [400 -> 796]       1 Step = 250 Meters     0.25 Mile
            case 40...99:       return 5    //Steps: [200 -> 495]       1 Step = 200 Meters     0.2 Mile
            case 20...39:       return 10   //Steps: [200 -> 390]       1 Step = 100 Meters     0.1 Mile
            case 8...19:        return 20   //Steps: [160 -> 380]       1 Step = 50 Meters      0.05 Mile
            case 4...7:         return 50   //Steps: [200 -> 350]       1 Step = 20 Meters      0.02 Mile
            case 1...3:         return 100  //Steps: [100 -> 300]       1 Step = 10 Meters      0.01 Mile
            default: break
            }
        default: break
        }
        
        return 1
    }
    
    
    //MARK: - AddArrays
    //One can take less stepUnits than one step. 
    
    func getStepAddArrays(from neededStepUnits: Int16) -> (unit: [String], dual: [String]) {
        
        var array: (unit: [Int], dual: [Int]) = ([], [])
        
        switch self {
        case .hours:
            array = ([], Array(1...10))
            
            switch neededStepUnits {
            case 30...89:       array.unit.append(contentsOf: Array(0...1))
            case 90...199:      array.unit.append(contentsOf: Array(0...2))
            case 200...399:     array.unit.append(contentsOf: Array(0...5))
            case 400...1000:    array.unit.append(contentsOf: Array(0...10))
            default: break
            }
            
            if 4...1000 ~= neededStepUnits { array.dual.append(contentsOf: [12, 14, 16, 18, 20]) }
            if 30...1000 ~= neededStepUnits {
                array.unit.append(-1)
                array.dual.append(contentsOf: [25, 30, 40, 50])
                array.dual.insert(0, at: 0)
            }
            
            array.dual.append(-1)

        case .km, .miles:
            
            switch neededStepUnits {
            case 20...39:       array.unit.append(contentsOf: Array(0...1))
            case 40...99:       array.unit.append(contentsOf: Array(0...1))
            case 100...199:     array.unit.append(contentsOf: Array(0...2))
            case 200...399:     array.unit.append(contentsOf: Array(0...5))
            case 400...1000:    array.unit.append(contentsOf: Array(0...10))
            default: break
            }
            
            array.dual = [10, 50, 100, 200, 300, 400, 500, -100]
            
            if 20...1000 ~= neededStepUnits {
                array.unit.append(-1)
                array.dual.insert(0, at: 0)
            }
            
        default:
            array = (Array(1...3), [])
            
            switch neededStepUnits {
            case 30...99:       array.unit.append(contentsOf: Array(4...5))
            case 100...299:     array.unit.append(contentsOf: Array(4...10))
            case 300...1000:    array.unit.append(contentsOf: Array(4...10))
                array.unit.append(contentsOf: [15, 20])
            default: break
            }
            
            array.unit.append(-1)
        }
        
        let dualArray: [Double] = array.dual.map { self == .miles ? Double($0)/1000 : Double($0) }

        return (array.unit.map { "\($0)" }, dualArray.map { $0.removeTrailingZerosToString() })
    }
    
    
    //MARK: - Category
    
    static func unitsOfCategory(_ category: StepCategory) -> [StepUnit] {
        switch category {
        case .duration: return [.hours, .min]
        case .distance: return [.km, .m, .miles, .feets]
        case .reps: return [.times, .pages, .steps, .decisions, .trees, .books, .custom]
        }
    }
    
    
    var category: StepCategory {
        switch self {
        case .hours, .min:              return .duration
        case .km, .m, .miles, .feets:   return .distance
        default:                        return .reps 
        }
    }
    
    var isMetric: Bool { self == .km || self == .m }
    var isImperial: Bool { self == .miles || self == .feets }
}
