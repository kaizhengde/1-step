//
//  MilestoneImage.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

@objc
enum MilestoneImage: Int16 {
    
    case one    = 1
    case two    = 2
    case three  = 3
    case four   = 4
    case five   = 5
    case six    = 6
    case seven  = 7
    case eigth  = 8
    case nine   = 9
    case ten    = 10
    case eleven = 11
    case twelve = 12
    case summit = 13
    
    
    var image: Image {
        switch self {
        case .one:      return SFSymbol.rosette
        case .two:      return SFSymbol.rosette
        case .three:    return SFSymbol.rosette
        case .four:     return SFSymbol.rosette
        case .five:     return SFSymbol.rosette
        case .six:      return SFSymbol.rosette
        case .seven:    return SFSymbol.rosette
        case .eigth:    return SFSymbol.rosette
        case .nine:     return SFSymbol.rosette
        case .ten:      return SFSymbol.rosette
        case .eleven:   return SFSymbol.rosette
        case .twelve:   return SFSymbol.rosette
        case .summit:   return SFSymbol.rosette
        }
    }
}



