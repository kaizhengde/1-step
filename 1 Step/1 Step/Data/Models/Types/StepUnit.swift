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
    
    
    var isCustom: Bool { self == .custom }
    
    
    //MARK: - Description
    
    var description: (plural: String, singular: String) {
        switch self {
        case .hours:        return ("hours"     , "hour")
        case .min:          return ("min"       , "min")
        case .km:           return ("km"        , "km")
        case .m:            return ("m"         , "m")
        case .miles:        return ("miles"     , "mile")
        case .feets:        return ("feets"     , "feet")
        case .times:        return ("times"     , "time")
        case .pages:        return ("pages"     , "page")
        case .steps:        return ("steps"     , "step")
        case .decisions:    return ("decisions" , "decision")
        case .trees:        return ("trees"     , "tree")
        case .books:        return ("books"     , "book")
        case .custom:       return ("custom"    , "custom")
        }
    }
    
    
    //MARK: - DualUnit
    
    var isDualUnit: Bool {
        switch self {
        case .hours, .km, .miles:
            return true
        default:
            return false
        }
    }
    
    var dualUnit: Self? {
        guard self.isDualUnit else { return nil }
        
        switch self {
        case .hours:    return .min
        case .km:       return .m
        case .miles:    return .miles
        default:        return nil
        }
    }
    
    
    //MARK: - Ratio
    
    func getRatio(from neededStepUnits: Int16) -> Int16 {
        
        guard self.isDualUnit else { return 1 }
        
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
    
    
    //MARK: - AddArray
    
    func getStepArray(from neededStepUnits: Int16) -> [String] {
        
        var array: [Int] = []
        var scale: Double = 1
        
        switch self {
        case .hours:
            switch neededStepUnits {
            case 400...1000:    array = Array(1...300)
            case 200...399:     array = Array(1...120)
            case 90...199:      array = Array(1...60)
            case 60...89:       array = Array(1...60)
            case 30...59:       array = Array(1...30)
            case 15...29:       array = Array(1...30)
            case 8...14:        array = Array(1...30)
            case 4...7:         array = Array(1...30)
            case 1...3:         array = Array(1...15)
            default: break
            }
            
        case .km, .miles:
            switch neededStepUnits {
            case 400...1000:    array = Array(10...1500)
            case 200...399:     array = Array(10...1000)
            case 100...199:     array = Array(10...500)
            case 40...99:       array = Array(10...200)
            case 20...39:       array = Array(10...200)
            case 8...19:        array = Array(5...100)
            case 4...7:         array = Array(1...50)
            case 1...3:         array = Array(1...20)
            default: break
            }
            
            scale = self == .km ? 10 : 0.01
            array = array.filter { $0%array.first! == 0 }
            
        default:
            switch neededStepUnits {
            case 300...1000:
                array = Array(1...10)
                array.append(15)
                array.append(20)
            case 100...299:       array = Array(1...10)
            case 30...99:         array = Array(1...5)
            case 10...29:         array = Array(1...3)
            default: break
            }
        }
        
        var arrayWithScale = array.map { Double($0)*scale }
        arrayWithScale.append((-1)*scale)
        
        return arrayWithScale.map { $0.removeTrailingZerosToString() }
    }
    
    
    //MARK: - Methods
    
    static func unitsOfCategory(_ category: StepCategory) -> [StepUnit] {
        switch category {
        case .duration: return [.hours, .min]
        case .distance: return [.km, .m, .miles, .feets]
        case .reps: return [.times, .pages, .steps, .decisions, .trees, .books, .custom]
        }
    }
}
