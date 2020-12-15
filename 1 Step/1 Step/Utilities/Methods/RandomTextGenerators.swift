//
//  RandomTextGenerators.swift
//  1 Step
//
//  Created by Kai Zheng on 15.12.20.
//

import Foundation

enum RandomText {
    
    static func congrats() -> String {
        switch Int.random(in: 0...3) {
        case 0:     return Localized.awesome
        case 1:     return Localized.amazing
        case 2:     return Localized.great
        default:    return Localized.incredible
        }
    }
}
