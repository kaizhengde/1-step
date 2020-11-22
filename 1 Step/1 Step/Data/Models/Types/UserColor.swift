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
    
    
    func get(_ art: UserColorArt = .normal) -> Color {
        let selectedColorTheme = UserDefaultsManager.shared.settingColorTheme
        
        switch art {
        case .normal:
            switch self {
            case .user0: return selectedColorTheme.color0.standard
            case .user1: return selectedColorTheme.color1.standard
            case .user2: return selectedColorTheme.color2.standard
            }
        case .light:
            switch self {
            case .user0: return selectedColorTheme.color0.light
            case .user1: return selectedColorTheme.color1.light
            case .user2: return selectedColorTheme.color2.light
            }
        case .dark:
            switch self {
            case .user0: return selectedColorTheme.color0.dark
            case .user1: return selectedColorTheme.color1.dark
            case .user2: return selectedColorTheme.color2.dark
            }
        }
    }
}
