//
//  MilestoneImage.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

@objc
enum MilestoneStage: Int16, CaseIterable {
    
    case none       = 0
    case first      = 1
    case second     = 2
    case third      = 3
    case fourth     = 4
    case fifth      = 5
    case sixth      = 6
    case seventh    = 7
    case eighth     = 8
    case ninth      = 9
    case tenth      = 10
    case eleventh   = 11
    case twelfth    = 12
    case summit     = 13
    
    
    var infos: (prev: Self, image: Image) {
        switch self {
        case .none:         return (.none,      SFSymbol.rosette)
        case .first:        return (.none,      SFSymbol.rosette)
        case .second:       return (.first,     SFSymbol.rosette)
        case .third:        return (.second,    SFSymbol.rosette)
        case .fourth:       return (.third,     SFSymbol.rosette)
        case .fifth:        return (.fourth,    SFSymbol.rosette)
        case .sixth:        return (.fifth,     SFSymbol.rosette)
        case .seventh:      return (.sixth,     SFSymbol.rosette)
        case .eighth:       return (.seventh,   SFSymbol.rosette)
        case .ninth:        return (.eighth,    SFSymbol.rosette)
        case .tenth:        return (.ninth,     SFSymbol.rosette)
        case .eleventh:     return (.tenth,     SFSymbol.rosette)
        case .twelfth:      return (.eleventh,  SFSymbol.rosette)
        case .summit:       return (.twelfth,   SFSymbol.rosette)
        }
    }
    
    
    enum MilestoneSteps {
        case small, big
    }

    
    func neededStepUnits(_ milestoneSteps: MilestoneSteps) -> Int16 {
        let small = milestoneSteps == .small
        
        switch self {
        case .none:         return 0
        case .first:        return small ? 1 : 10
        case .second:       return small ? 2 : 25
        case .third:        return small ? 3 : 50
        case .fourth:       return small ? 4 : 100
        case .fifth:        return small ? 5 : 200
        case .sixth:        return small ? 6 : 300
        case .seventh:      return small ? 7 : 400
        case .eighth:       return small ? 8 : 500
        case .ninth:        return small ? 9 : 600
        case .tenth:        return small ? 10 : 700
        case .eleventh:     return small ? 10 : 800
        case .twelfth:      return small ? 10 : 900
        case .summit:       return small ? 10 : 1000
        }
    }
    
    
    static func stageFrom(neededStepUnits: Int16, _ milestoneSteps: MilestoneSteps) -> Self {
        let small = milestoneSteps == .small
        
        if small {
            switch neededStepUnits {
            case 0:     return .none
            case 1:     return .first
            case 2:     return .second
            case 3:     return .third
            case 4:     return .fourth
            case 5:     return .fifth
            case 6:     return .sixth
            case 7:     return .seventh
            case 8:     return .eighth
            case 9:     return .ninth
            case 10:    return .summit
            default:    return .none
            }
        } else {
            switch neededStepUnits {
            case 0:     return .none
            case 10:    return .first
            case 25:    return .second
            case 50:    return .third
            case 100:   return .fourth
            case 200:   return .fifth
            case 300:   return .sixth
            case 400:   return .seventh
            case 500:   return .eighth
            case 600:   return .ninth
            case 700:   return .tenth
            case 800:   return .eleventh
            case 900:   return .twelfth
            case 1000:  return .summit
            default:    return .none
            }
        }
    }
}
