//
//  OneSColorTheme.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSColorTheme: String, Codable, CaseIterable {
    case `default`  = "Default"
    case pastel     = "Pastel"
    case fall       = "Fall"
}

extension OneSColorTheme: UserDefaultType {}

