//
//  MilestoneImage.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

@objc
enum MilestoneImage: Int16 {
    
    case one    = 0
    case two    = 1
    case three  = 2
    case four   = 3
    case five   = 4
    case six    = 5
    case seven  = 6
    case eigth  = 7
    case summit = 8
    
    
    func get() -> Image {
        switch self {
        case .one:      return Image(systemName: "house")
        case .two:      return Image("TreeSymbol")
        case .three:    return Image("CowSymbol")
        case .four:     return Image("GrassSymbol")
        case .five:     return Image("StoneSymbol")
        case .six:      return Image(systemName: "cloud")
        case .seven:    return Image(systemName: "wind")
        case .eigth:    return Image(systemName: "snow")
        case .summit:   return Image(systemName: "flag")
        }
    }
    
    
    var isCustom: Bool {
        switch self {
        case .two, .three, .four, .five: return true
        default: return false
        }
    }
}



