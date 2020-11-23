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
}


enum Symbol {
    
    static let longArrowDown    = Image("LongArrowDown")
}


enum Flag {
    
    static let flag             = Image("Flag")
    static let flagLine         = Image("FlagLine")
    static let flagFlag         = Image("FlagFlag")
}


enum Emoji {
    
    static let deer             = Image("DeerEmoji")
}


enum ProfileSymbol {
    
    static let settings         = Image("SettingsSymbol")
    static let dataAndPrivacy   = Image(systemName: "hand.raised")
    static let help             = Image(systemName: "questionmark.circle")
    static let share            = Image(systemName: "square.and.arrow.up")
    static let rate             = Image(systemName: "star")
    static let feedback         = Image(systemName: "message")
    static let website          = Image(systemName: "globe")
    static let instagram        = Image(systemName: "camera.circle")
    static let vfdCollective    = Image(systemName: "light.max")
    static let pastelTree       = Image(systemName: "paintbrush")
}


enum HeaderButtonSymbol {
    
    case profile, close, back, settings, custom(AnyView)
            
    
    func get() -> Image {
        switch self {
        case .profile:  return Image("ProfileSymbol")
        case .close:    return Image("CloseSymbol")
        case .back:     return Image("BackSymbol")
        case .settings: return Image("SettingsFillSymbol")
        case .custom(_): return Image("")
        }
    }
    
    
    func isCustom() -> Bool {
        switch self {
        case .custom(_): return true
        default: return false 
        }
    }
    
    
    func getCustom() -> AnyView {
        switch self {
        case let .custom(view): return view
        default: return AnyView(EmptyView())
        }
    }
}


enum SecondaryHeaderButtonSymbol {
    
    case `continue`, save, delete
    
    
    func get() -> Image {
        switch self {
        case .continue: return SFSymbol.`continue`
        case .save:     return SFSymbol.check
        case .delete:   return SFSymbol.delete
        }
    }
}



