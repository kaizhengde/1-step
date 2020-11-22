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
    
    
    var standard: Color {
        switch self {
        case .user0: return UserDefaultsManager.shared.settingColorTheme.color0.standard
        case .user1: return UserDefaultsManager.shared.settingColorTheme.color1.standard
        case .user2: return UserDefaultsManager.shared.settingColorTheme.color2.standard
        }
    }
    
    
    var light: Color {
        switch self {
        case .user0: return UserDefaultsManager.shared.settingColorTheme.color0.light
        case .user1: return UserDefaultsManager.shared.settingColorTheme.color1.light
        case .user2: return UserDefaultsManager.shared.settingColorTheme.color2.light
        }
    }
    
    
    var dark: Color {
        switch self {
        case .user0: return UserDefaultsManager.shared.settingColorTheme.color0.dark
        case .user1: return UserDefaultsManager.shared.settingColorTheme.color1.dark
        case .user2: return UserDefaultsManager.shared.settingColorTheme.color2.dark
        }
    }
}
