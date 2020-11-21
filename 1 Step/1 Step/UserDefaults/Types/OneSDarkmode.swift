//
//  OneSDarkmode.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSDarkmode: String, Codable {
    case mirrorDeviceSettings
    case light
    case dark
}

extension OneSDarkmode: UserDefaultType {}
