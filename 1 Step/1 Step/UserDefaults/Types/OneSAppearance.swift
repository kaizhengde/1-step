//
//  OneSDarkmode.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSAppearance: String, Codable, CaseIterable {
    case mirrorDevice   = "Mirror device"
    case light          = "Light"
    case dark           = "Dark"
}

extension OneSAppearance: UserDefaultType {}
