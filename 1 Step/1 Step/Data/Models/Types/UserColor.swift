//
//  UserColor.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

@objc
enum UserColor: Int16 {
    
    case user0 = 0
    case user1 = 1
    case user2 = 2
    
    enum UserColorArt {
        case normal, light, dark
    }
    
    
    func get(_ art: UserColorArt = .normal) -> Color {
        switch art {
        case .normal:
            switch self {
            case .user0: return OneSColorPalette.Default.color0.standard
            case .user1: return OneSColorPalette.Default.color1.standard
            case .user2: return OneSColorPalette.Default.color2.standard
            }
        case .light:
            switch self {
            case .user0: return OneSColorPalette.Default.color0.light
            case .user1: return OneSColorPalette.Default.color1.light
            case .user2: return OneSColorPalette.Default.color2.light
            }
        case .dark:
            switch self {
            case .user0: return OneSColorPalette.Default.color0.dark
            case .user1: return OneSColorPalette.Default.color1.dark
            case .user2: return OneSColorPalette.Default.color2.dark
            }
        }
    }
}
