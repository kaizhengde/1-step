//
//  MilestoneStages.swift
//  1 Step
//
//  Created by Kai Zheng on 24.10.20.
//

import SwiftUI

struct MilestoneStages {
    
    typealias NeededStepUnitsData = (one: Double, two: Double, five: Double, ten: Double,  twenty: Double,  fifty: Double,  thousand: Double)
    
    enum MaxNeededStepUnits {
        case thousand
        case fifty
        case twenty
        case ten
        case five
        case two
        case one
    }
    
    
    static func getMaxNeededStepUnits(from neededStepUnits: Int16) -> MaxNeededStepUnits {
        switch neededStepUnits {
        case 100...1000:    return .thousand
        case 50...99:       return .fifty
        case 20...49:       return .twenty
        case 10...19:       return .ten
        case 5...9:         return .five
        case 2...4:         return .two
        case 1:             return .one
        default:            return .thousand
        }
    }
    
    
    var maxNeededStepUnits: MaxNeededStepUnits
    
    var neededStepUnits: [Double] {
        switch maxNeededStepUnits {
        case .thousand:     return neededStepUnitsData.map { $0.thousand }
        case .fifty:        return neededStepUnitsData.map { $0.fifty }
        case .twenty:       return neededStepUnitsData.map { $0.twenty }
        case .ten:          return neededStepUnitsData.map { $0.ten }
        case .five:         return neededStepUnitsData.map { $0.five }
        case .two:          return neededStepUnitsData.map { $0.two }
        case .one:          return neededStepUnitsData.map { $0.one }
        }
    }
    
    
    var neededStepUnitsData: [NeededStepUnitsData] = [
        (one: 0.1,  two: 0.2,  five: 0.5,  ten: 1,    twenty: 2,    fifty: 5,    thousand: 10),
        (one: 0.2,  two: 0.4,  five: 1.0,  ten: 2,    twenty: 5,    fifty: 10,   thousand: 25),
        (one: 0.4,  two: 1.0,  five: 2.0,  ten: 5,    twenty: 10,   fifty: 20,   thousand: 50),
        (one: 1.0,  two: 2.0,  five: 5.0,  ten: 10,   twenty: 20,   fifty: 50,   thousand: 100),
        (one: 1000, two: 1000, five: 1000, ten: 1000, twenty: 1000, fifty: 1000, thousand: 200),
        (one: 1000, two: 1000, five: 1000, ten: 1000, twenty: 1000, fifty: 1000, thousand: 400),
        (one: 1000, two: 1000, five: 1000, ten: 1000, twenty: 1000, fifty: 1000, thousand: 600),
        (one: 1000, two: 1000, five: 1000, ten: 1000, twenty: 1000, fifty: 1000, thousand: 800),
        (one: 1000, two: 1000, five: 1000, ten: 1000, twenty: 1000, fifty: 1000, thousand: 1000)
    ]
}
