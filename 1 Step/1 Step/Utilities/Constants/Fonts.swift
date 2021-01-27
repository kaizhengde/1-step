//
//  Fonts.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum OneSFont {
    
    case header, header2, title, title2, subtitle, body, body2, footnote, footnote2, custom(Raleway, CGFloat)

    var font: Font {
        switch self {
        case .header:       return Font.custom(Raleway.extraBold.weight,    size: 40)
        case .header2:      return Font.custom(Raleway.extraBold.weight,    size: 30)
        case .title:        return Font.custom(Raleway.bold.weight,         size: 32)
        case .title2:       return Font.custom(Raleway.extraBold.weight,    size: 22)
        case .subtitle:     return Font.custom(Raleway.bold.weight,         size: 16)
        case .body:         return Font.custom(Raleway.medium.weight,       size: 17)
        case .body2:        return Font.custom(Raleway.regular.weight,      size: 17)
        case .footnote:     return Font.custom(Raleway.regular.weight,      size: 16)
        case .footnote2:    return Font.custom(Raleway.regular.weight,      size: 13)
        case let .custom(weight, size):
            return Font.custom(weight.weight, size: size)
        }
    }
    
    var uiFont: UIFont {
        switch self {
        case .header:       return UIFont(name: Raleway.extraBold.weight,    size: 40)!
        case .header2:      return UIFont(name: Raleway.extraBold.weight,    size: 30)!
        case .title:        return UIFont(name: Raleway.bold.weight,         size: 32)!
        case .title2:       return UIFont(name: Raleway.extraBold.weight,    size: 22)!
        case .subtitle:     return UIFont(name: Raleway.bold.weight,         size: 16)!
        case .body:         return UIFont(name: Raleway.medium.weight,       size: 17)!
        case .body2:        return UIFont(name: Raleway.regular.weight,      size: 17)!
        case .footnote:     return UIFont(name: Raleway.regular.weight,      size: 16)!
        case .footnote2:    return UIFont(name: Raleway.regular.weight,      size: 13)!
        case let .custom(weight, size):
            return UIFont(name: weight.weight, size: size)!
        }
    }
}


enum Raleway: String {

    case black        = "Raleway-Black"
    case extraBold    = "Raleway-ExtraBold"
    case bold         = "Raleway-Bold"
    case semiBold     = "Raleway-SemiBold"
    case medium       = "Raleway-Medium"
    case regular      = "Raleway-Regular"
    case light        = "Raleway-Light"
    case extraLight   = "Raleway-ExtraLight"
    case thin         = "Raleway-Thin"
    
    var weight: String { return self.rawValue }
}
