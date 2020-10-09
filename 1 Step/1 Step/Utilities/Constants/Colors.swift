//
//  Colors.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum UserColor: Int16 {
    
    case user0 = 0
    case user1 = 1
    case user2 = 2
    case user3 = 3
    
    
    func get() -> Color {
        switch self {
        case .user0: return Color("User0")
        case .user1: return Color("User1")
        case .user2: return Color("User2")
        case .user3: return Color("User3")
        }
    }
}


extension Color {
    
    static let whiteToDarkGray = Color("WhiteToDarkGray")
    static let grayToBackground = Color("GrayToBackground")
    static let darkBackgroundToBlack = Color("DarkBackgroundToBlack")
    static let neutralToDarkNeutral = Color("NeutralToDarkNeutral")
    static let lightNeutralToLightGray = Color("LightNeutralToLightGray")
    static let backgroundToGray = Color("BackgroundToGray")
    static let darkBackgroundToDarkGray = Color("DarkBackgroundToDarkGray")
    static let darkBackgroundToGray = Color("DarkBackgroundToGray")
    
    static let opacityBlur = Color("OpacityBlur")
}



