//
//  Layout.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI 

enum Layout {
    
    static let screenWidth                  = UIScreen.main.bounds.size.width
    static let screenHeight                 = UIScreen.main.bounds.size.height
    
    static let multiplierWidth: CGFloat     = screenWidth/375.0
    static let multiplierHeight: CGFloat    = screenHeight/812.0
    
    static let firstLayerPadding: CGFloat   = 24.0
    static let secondLayerPadding: CGFloat  = 40.0
    static let firstLayerWidth              = screenWidth - (2.0 * firstLayerPadding)
    static let secondLayerWidth             = screenWidth - (2.0 * secondLayerPadding)
    
    static let screenTopPadding: CGFloat    = 20.0 + onlyOniPhoneXType(-20.0)
    static let sheetTopPadding: CGFloat     = onlyOniPhoneXType(16.0)
    
    static let popoverWidth: CGFloat = 260*multiplierWidth
    static let floaterWidth: CGFloat = secondLayerWidth
    
    static func onlyOniPhoneXType(_ value: CGFloat) -> CGFloat {
        return Device.isiPhoneXType ? value : 0
    }
}
    
    
enum Device {
        
    static let idiom                        = UIDevice.current.userInterfaceIdiom
    static let nativeScale                  = UIScreen.main.nativeScale
    static let scale                        = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && Layout.screenHeight == 568.0
    static let isiPhone8Standard            = idiom == .phone && Layout.screenHeight == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && Layout.screenHeight == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && Layout.screenHeight == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && Layout.screenHeight == 736.0 && nativeScale < scale
    static let isiPhoneXAnd11And12Mini      = idiom == .phone && Layout.screenHeight == 812.0
    static let isiPhoneXsMaxAndXrAnd11Max   = idiom == .phone && Layout.screenHeight == 896.0
    static let isiPhone12                   = idiom == .phone && Layout.screenHeight == 844.0
    static let isiPhone12ProMax             = idiom == .phone && Layout.screenHeight == 926.0

    static private let isiPhone12Type: Bool = { return isiPhone12 || isiPhone12ProMax }()
    static let isiPhoneXType: Bool = { return isiPhoneXAnd11And12Mini || isiPhoneXsMaxAndXrAnd11Max || isiPhone12Type }()
}


enum SafeAreaSize {
    
    static let topX: CGFloat        = 44.0
    static let bottomX: CGFloat     = 34.0
    static let topRest: CGFloat     = 20.0
    static let bottomRest: CGFloat  = 0.0
    
    static let top                  = Device.isiPhoneXType ? topX : topRest
    static let bottom               = Device.isiPhoneXType ? bottomX : bottomRest
}


enum MountainLayout {
    
    static let offsetY: CGFloat             = Layout.screenHeight/3.2 + Layout.screenTopPadding
    static let offsetYNoScrollView          = offsetY - Layout.onlyOniPhoneXType(SafeAreaSize.top) - 10
    static let offsetYText                  = offsetY - 80 - 20*Layout.multiplierHeight
    static let offsetYTextNoScrollView      = offsetYNoScrollView - 80 - 20*Layout.multiplierHeight
    static let offsetYFlag                  = -36*Layout.multiplierHeight
    
    static let height: CGFloat              = 626.0 * Layout.multiplierWidth
    static let withFlagHeight: CGFloat      = 670.0 * Layout.multiplierWidth
    static let premiumHeight: CGFloat       = 585.0 * Layout.multiplierWidth
}


enum TutorialGIFLayout {
    
    static let width: CGFloat   = Layout.popoverWidth+1
    static let height: CGFloat  = 1297.0*(width/600.0)
}
