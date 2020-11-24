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
    
    
    var image: Image {
        switch self {
        case .one:      return Self.house
        case .two:      return Self.tree
        case .three:    return Self.cow
        case .four:     return Self.flower
        case .five:     return Self.stone
        case .six:      return Self.cloud
        case .seven:    return Self.wind
        case .eigth:    return Self.snow
        case .summit:   return Self.flag
        }
    }
    
    
    var isCustom: Bool {
        switch self {
        case .two, .three, .four, .five: return true
        default: return false
        }
    }
}



