//
//  OneSDarkmode.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSAppearance: String, Codable, CaseIterable {
    
    case mirrorDevice
    case light
    case dark
    
    var description: String {
        switch self {
        case .mirrorDevice: return Localized.mirrorDevice
        case .light:        return Localized.light
        case .dark:         return Localized.dark
        }
    }
}

extension OneSAppearance: UserDefaultType {}
