//
//  Fonts.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum OneSFont {
    
    case header, title, title2, subtitle, body, body2, footnote, footnote2, custom(font: String, size: CGFloat)
    
    func get() -> Font {
        switch self {
        case .header:       return Font.custom(Raleway.extraBold, size: 40)
        case .title:        return Font.custom(Raleway.bold, size: 32)
        case .title2:       return Font.custom(Raleway.extraBold, size: 22)
        case .subtitle:     return Font.custom(Raleway.semiBold, size: 15)
        case .body:         return Font.custom(Raleway.medium, size: 17)
        case .body2:        return Font.custom(Raleway.regular, size: 17)
        case .footnote:     return Font.custom(Raleway.regular, size: 15)
        case .footnote2:    return Font.custom(Raleway.regular, size: 12)
        case let .custom(font: font, size: size):
            return Font.custom(font, size: size)
        }
    }
}


enum Raleway {
    
    static let black        = "Raleway-Black"
    static let extraBold    = "Raleway-ExtraBold"
    static let bold         = "Raleway-Bold"
    static let semiBold     = "Raleway-SemiBold"
    static let medium       = "Raleway-Medium"
    static let regular      = "Raleway-Regular"
    static let light        = "Raleway-Light"
    static let extraLight   = "Raleway-ExtraLight"
    static let thin         = "Raleway-Thin"
}
