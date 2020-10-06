//
//  Layout.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI 

enum Layout {
    
    static let firstLayerPadding: CGFloat   = 24.0
    static let secondLayerPadding: CGFloat  = 40.0
    static let firstLayerWidth              = ScreenSize.width - (2.0 * firstLayerPadding)
    static let secondLayerWidth             = ScreenSize.width - (2.0 * secondLayerPadding)
}


enum ScreenSize {
    
    static let width                        = UIScreen.main.bounds.size.width
    static let height                       = UIScreen.main.bounds.size.height
    static let maxLength                    = max(width, height)
    static let minLength                    = min(width, height)
    
    static let multiplierWidth: CGFloat = width/375.0
    static let multiplierHeight: CGFloat = height/812.0
}
    
    
enum DeviceTypes {
        
    static let idiom                        = UIDevice.current.userInterfaceIdiom
    static let nativeScale                  = UIScreen.main.nativeScale
    static let scale                        = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                    = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr           = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                       = idiom == .pad && ScreenSize.maxLength >= 1024.0

    
    static let isiPhoneXAspectRatio = {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }()
}


enum SafeAreaSize {
    
    //Note: Only for Portrait-Mode
    
    static let safeAreaTopX: CGFloat        = 44.0
    static let safeAreaBottomX: CGFloat     = 34.0
    static let safeAreaTopRest: CGFloat     = 20.0
    static let safeAreaBottomRest: CGFloat  = 0.0
    
    static let safeAreaTop                  = DeviceTypes.isiPhoneXAspectRatio ? safeAreaTopX : safeAreaTopRest
    static let safeAreaBottom               = DeviceTypes.isiPhoneXAspectRatio ? safeAreaBottomX : safeAreaBottomRest
}


enum MountainLayout {
    
    static let offsetY: CGFloat             = ScreenSize.height/3.2
    static let height: CGFloat              = 626.0 * ScreenSize.multiplierWidth
    static let withFlagHeight: CGFloat      = 670.0 * ScreenSize.multiplierWidth
}
