//
//  OneSColorTheme.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

typealias OneSColorThemeType = (standard: Color, light: Color, dark: Color)

enum OneSColorTheme: String, Codable, CaseIterable {
    
    case `default`  = "Default"
    case pastel     = "Pastel"
    case fall       = "Fall"
    
    
    var color0: OneSColorThemeType {
        switch self {
        case .default: return Default.color0
        case .pastel: return Pastel.color0
        case .fall: return Fall.color0
        }
    }
    
    var color1: OneSColorThemeType {
        switch self {
        case .default: return Default.color1
        case .pastel: return Pastel.color1
        case .fall: return Fall.color1
        }
    }
    
    var color2: OneSColorThemeType {
        switch self {
        case .default: return Default.color2
        case .pastel: return Pastel.color2
        case .fall: return Fall.color2
        }
    }
}

extension OneSColorTheme: UserDefaultType {}

