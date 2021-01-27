//
//  OneSColorTheme.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

typealias OneSColorThemeType = (standard: Color, light: Color, dark: Color)

enum OneSColorTheme: String, Codable, CaseIterable {
    
    case water
    case earth
    case air
    
    var color0: OneSColorThemeType {
        switch self {
        case .water: return Water.color0
        case .earth: return Earth.color0
        case .air:   return Air.color0
        }
    }
    
    var color1: OneSColorThemeType {
        switch self {
        case .water: return Water.color1
        case .earth: return Earth.color1
        case .air:   return Air.color1
        }
    }
    
    var color2: OneSColorThemeType {
        switch self {
        case .water: return Water.color2
        case .earth: return Earth.color2
        case .air:   return Air.color2
        }
    }
    
    var description: String {
        switch self {
        case .water:    return Localized.water
        case .earth:    return Localized.earth
        case .air:      return Localized.air
        }
    }
}

extension OneSColorTheme: UserDefaultType {}

