//
//  OneSLanguage.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum OneSLanguage: String, Codable {
    case english
    case german
    case chinese
}

extension OneSLanguage: UserDefaultType {}
