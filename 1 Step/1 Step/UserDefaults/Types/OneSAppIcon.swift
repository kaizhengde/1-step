//
//  OneSAppIcon.swift
//  1 Step
//
//  Created by Kai Zheng on 27.01.21.
//

import SwiftUI

enum OneSAppIcon: String, Codable, CaseIterable {
    
    case waterLight
    case earthLight
    case airLight
    case waterDark
    case earthDark
    case airDark
    
    static var lightIcons: [OneSAppIcon] = [.waterLight, .earthLight, .airLight]
    static var darkIcons: [OneSAppIcon] = [.waterDark, .earthDark, .airDark]
    
    var description: String {
        switch self {
        case .waterLight:    return "\(Localized.water) \(Localized.light)"
        case .earthLight:    return "\(Localized.earth) \(Localized.light)"
        case .airLight:      return "\(Localized.air) \(Localized.light)"
        case .waterDark:     return "\(Localized.water) \(Localized.dark)"
        case .earthDark:     return "\(Localized.earth) \(Localized.dark)"
        case .airDark:       return "\(Localized.air) \(Localized.dark)"
        }
    }
    
    var image: Image {
        switch self {
        case .waterLight:    return AppIconImage.waterLight
        case .earthLight:    return AppIconImage.earthLight
        case .airLight:      return AppIconImage.airLight
        case .waterDark:     return AppIconImage.waterDark
        case .earthDark:     return AppIconImage.earthDark
        case .airDark:       return AppIconImage.airDark
        }
    }
    
    var iconString: String? {
        switch self {
        case .waterLight:    return nil
        case .earthLight:    return "1StepIconEarth"
        case .airLight:      return "1StepIconAir"
        case .waterDark:     return "1StepIconDark"
        case .earthDark:     return "1StepIconEarthDark"
        case .airDark:       return "1StepIconAirDark"
        }
    }
}

extension OneSAppIcon: UserDefaultType {}
