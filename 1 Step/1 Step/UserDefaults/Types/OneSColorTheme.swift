//
//  OneSColorTheme.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSColorTheme: String, Codable {
    case `default`
    case pastel
    case fall
}

extension OneSColorTheme: UserDefaultType {}

