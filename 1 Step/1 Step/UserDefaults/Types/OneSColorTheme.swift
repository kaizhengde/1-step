//
//  OneSColorTheme.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

typealias OneSColorThemeType = (standard: Color, light: Color, dark: Color)

enum OneSColorTheme: String, Codable, CaseIterable {
    
    case water  = "Water"
    case earth  = "Earth"
    case fire   = "Fire"
    case air    = "Air"
    
    
    var color0: OneSColorThemeType {
        switch self {
        case .water: return Water.color0
        case .earth: return Earth.color0
        case .fire:  return Fire.color0
        case .air:   return Air.color0
        }
    }
    
    var color1: OneSColorThemeType {
        switch self {
        case .water: return Water.color1
        case .earth: return Earth.color1
        case .fire:  return Fire.color1
        case .air:   return Air.color1
        }
    }
    
    var color2: OneSColorThemeType {
        switch self {
        case .water: return Water.color2
        case .earth: return Earth.color2
        case .fire:  return Fire.color2
        case .air:   return Air.color2
        }
    }
    
    var appIcon: String? {
        switch self {
        case .water: return nil
        case .earth: return "1StepIconEarth"
        case .fire:  return "1StepIconFire"
        case .air:   return "1StepIconAir"
        }
    }
}

extension OneSColorTheme: UserDefaultType {}

