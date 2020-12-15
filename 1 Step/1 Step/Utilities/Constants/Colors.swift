//
//  Colors.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

extension Color {
    
    static let whiteToDarkGray          = Color("WhiteToDarkGray")
    static let grayToBackground         = Color("GrayToBackground")
    static let darkBackgroundToBlack    = Color("DarkBackgroundToBlack")
    static let darkNeutralToNeutral     = Color("DarkNeutralToNeutral")
    static let neutralToDarkNeutral     = Color("NeutralToDarkNeutral")
    static let lightNeutralToLightGray  = Color("LightNeutralToLightGray")
    static let backgroundToGray         = Color("BackgroundToGray")
    static let darkBackgroundToDarkGray = Color("DarkBackgroundToDarkGray")
    static let darkBackgroundToGray     = Color("DarkBackgroundToGray")
    static let backgroundToDarkGray     = Color("BackgroundToDarkGray")
    static let backgroundToBlack        = Color("BackgroundToBlack")
    static let whiteToGray              = Color("WhiteToGray")
    
    static let backgroundStatic         = Color("BackgroundStatic")
    static let darkBackgroundStatic     = Color("DarkBackgroundStatic")
    static let darkGrayStatic           = Color("DarkGrayStatic")
    static let grayStatic               = Color("GrayStatic")
    static let blackStatic              = Color("BlackStatic")
    static let darkNeutralStatic        = Color("DarkNeutralStatic")
    static let neutralStatic            = Color("NeutralStatic")
    
    static let opacityBlur              = Color("OpacityBlur")
    static let opacityDarker            = Color("OpacityDarker")
    static let hidden                   = Color.black.opacity(0.0000001)
}


extension OneSColorTheme {
    
    enum Water {
        static let color0 = (standard: Color("Water0"), light: Color("Water0Light"), dark: Color("Water0Dark"))
        static let color1 = (standard: Color("Water1"), light: Color("Water1Light"), dark: Color("Water1Dark"))
        static let color2 = (standard: Color("Water2"), light: Color("Water2Light"), dark: Color("Water2Dark"))
    }

    
    enum Earth {
        static let color0 = (standard: Color("Earth0"), light: Color("Earth0Light"), dark: Color("Earth0Dark"))
        static let color1 = (standard: Color("Earth1"), light: Color("Earth1Light"), dark: Color("Earth1Dark"))
        static let color2 = (standard: Color("Earth2"), light: Color("Earth2Light"), dark: Color("Earth2Dark"))
    }
    
    
    enum Air {
        static let color0 = (standard: Color("Air0"), light: Color("Air0Light"), dark: Color("Air0Dark"))
        static let color1 = (standard: Color("Air1"), light: Color("Air1Light"), dark: Color("Air1Dark"))
        static let color2 = (standard: Color("Air2"), light: Color("Air2Light"), dark: Color("Air2Dark"))
    }
}


