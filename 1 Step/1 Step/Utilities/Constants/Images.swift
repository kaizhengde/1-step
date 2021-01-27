//
//  Constants.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum SFSymbol {
    
    static let `continue`       = Image(systemName: "arrow.right")
    static let delete           = Image(systemName: "trash.fill")
    static let check            = Image(systemName: "checkmark")
    static let checkmark        = Image(systemName: "checkmark.circle.fill")
    static let rosette          = Image(systemName: "rosette")
    static let plus             = Image(systemName: "plus")
    static let camera           = Image(systemName: "camera.fill")
    static let info             = Image(systemName: "info.circle.fill")
    static let clock            = Image(systemName: "clock")
    static let lock             = Image(systemName: "lock.fill")
}


enum Symbol {
    
    static let longArrowDown    = Image("LongArrowDown")
    static let deer             = Image("DeerEmoji")
}


enum ProfileSymbol {
    
    static let settings         = Image("SettingsSymbol")
    static let dataAndPrivacy   = Image(systemName: "hand.raised")
    static let help             = Image(systemName: "questionmark.circle")
    static let share            = Image(systemName: "square.and.arrow.up")
    static let rate             = Image(systemName: "star")
    static let feedback         = Image(systemName: "message")
    static let request          = Image(systemName: "flame")
    static let website          = Image(systemName: "globe")
    static let instagram        = Image(systemName: "camera.circle")
    static let vfdCollective    = Image(systemName: "light.max")
    static let pastelTree       = Image(systemName: "paintbrush")
    static let plant            = Image(systemName: "heart")
}


enum HeaderButtonSymbol {
    
    case profile, close, back, settings, custom(AnyView)
            
    
    func get() -> Image {
        switch self {
        case .profile:          return Image("ProfileSymbol")
        case .close:            return Image("CloseSymbol")
        case .back:             return Image("BackSymbol")
        case .settings:         return Image("SettingsFillSymbol")
        case .custom(_):        return Image("")
        }
    }
    
    
    func isCustom() -> Bool {
        switch self {
        case .custom(_):        return true
        default:                return false
        }
    }
    
    
    func getCustom() -> AnyView {
        switch self {
        case let .custom(view): return view
        default:                return AnyView(EmptyView())
        }
    }
}


enum SecondaryHeaderButtonSymbol {
    
    case `continue`, save, delete
    
    
    func get() -> Image {
        switch self {
        case .continue:         return SFSymbol.continue
        case .save:             return SFSymbol.check
        case .delete:           return SFSymbol.delete
        }
    }
}


extension MountainImage {
    
    enum Goal {
        
        static let mountain0    = Image("Mountain0")
        static let mountain1    = Image("Mountain1")
        static let mountain2    = Image("Mountain2")
    }
    
    
    enum Flag {
        
        static let whole        = Image("Flag")
        static let line         = Image("FlagLine")
        static let top          = Image("FlagFlag")
    }
    
    
    enum Premium {
        
        static let waterLight   = Image("MountainPremiumWaterLight")
        static let waterDark    = Image("MountainPremiumWaterDark")
            
        static let earthLight   = Image("MountainPremiumEarthLight")
        static let earthDark    = Image("MountainPremiumEarthDark")
           
        static let fireLight    = Image("MountainPremiumFireLight")
        static let fireDark     = Image("MountainPremiumFireDark")
        
        static let airLight     = Image("MountainPremiumAirLight")
        static let airDark      = Image("MountainPremiumAirDark")
            
        
        static var currentLight: Image {
            switch UserDefaultsManager.shared.settingColorTheme {
            case .water:    return waterLight
            case .earth:    return earthLight
            case .air:      return airLight
            }
        }
        
        static var currentDark: Image {
            switch UserDefaultsManager.shared.settingColorTheme {
            case .water:    return waterDark
            case .earth:    return earthDark
            case .air:      return airDark
            }
        }
    }
}


extension MilestoneImage {
    
    static let house    = Image(systemName: "house")
    static let tree     = Image("TreeSymbol")
    static let cow      = Image("CowSymbol")
    static let flower   = Image("GrassSymbol")
    static let stone    = Image("StoneSymbol")
    static let cloud    = Image(systemName: "cloud")
    static let wind     = Image(systemName: "wind")
    static let snow     = Image(systemName: "snow")
    static let flag     = Image(systemName: "flag")
}


enum Photo {
    
    static let givingBack = Image("GivingBackPhoto")
}


enum AppIconImage {
    
    static let waterLight   = Image("1StepIconWater")
    static let earthLight   = Image("1StepIconEarth")
    static let airLight     = Image("1StepIconAir")
    static let waterDark    = Image("1StepIconWaterDark")
    static let earthDark    = Image("1StepIconEarthDark")
    static let airDark      = Image("1StepIconAirDark")
}
