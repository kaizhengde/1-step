//
//  Colors.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

extension Color {
    
    static let whiteToDarkGray = Color("WhiteToDarkGray")
    static let grayToBackground = Color("GrayToBackground")
    static let darkBackgroundToBlack = Color("DarkBackgroundToBlack")
    static let darkNeutralToNeutral = Color("DarkNeutralToNeutral")
    static let neutralToDarkNeutral = Color("NeutralToDarkNeutral")
    static let lightNeutralToLightGray = Color("LightNeutralToLightGray")
    static let backgroundToGray = Color("BackgroundToGray")
    static let darkBackgroundToDarkGray = Color("DarkBackgroundToDarkGray")
    static let darkBackgroundToGray = Color("DarkBackgroundToGray")
    static let backgroundToDarkGray = Color("BackgroundToDarkGray")
    
    static let backgroundStatic = Color("BackgroundStatic")
    static let darkBackgroundStatic = Color("DarkBackgroundStatic")
    static let darkGrayStatic = Color("DarkGrayStatic")
    static let grayStatic = Color("GrayStatic")
    static let blackStatic = Color("BlackStatic")
    static let darkNeutralStatic = Color("DarkNeutralStatic")
    static let neutralStatic = Color("NeutralStatic")
    
    static let opacityBlur = Color("OpacityBlur")
    static let hidden = Color.black.opacity(0.0000001)
}


extension OneSColorTheme {
    
    enum Default {
        static let color0 = (standard: Color("Default0"), light: Color("Default0Light"), dark: Color("Default0Dark"))
        static let color1 = (standard: Color("Default1"), light: Color("Default1Light"), dark: Color("Default1Dark"))
        static let color2 = (standard: Color("Default2"), light: Color("Default2Light"), dark: Color("Default2Dark"))
    }

    
    enum Pastel {
        static let color0 = (standard: Color("Pastel0"), light: Color("Pastel0Light"), dark: Color("Pastel0Dark"))
        static let color1 = (standard: Color("Pastel1"), light: Color("Pastel1Light"), dark: Color("Pastel1Dark"))
        static let color2 = (standard: Color("Pastel2"), light: Color("Pastel2Light"), dark: Color("Pastel2Dark"))
    }
    
    
    enum Fall {
        static let color0 = (standard: Color("Fall0"), light: Color("Fall0Light"), dark: Color("Fall0Dark"))
        static let color1 = (standard: Color("Fall1"), light: Color("Fall1Light"), dark: Color("Fall1Dark"))
        static let color2 = (standard: Color("Fall2"), light: Color("Fall2Light"), dark: Color("Fall2Dark"))
    }
}


