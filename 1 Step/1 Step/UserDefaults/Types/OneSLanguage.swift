//
//  OneSLanguage.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSLanguage: String, Codable, CaseIterable {
    case english    = "English"
    case german     = "German"
    case chinese    = "Chinese"
}

extension OneSLanguage: UserDefaultType {}
