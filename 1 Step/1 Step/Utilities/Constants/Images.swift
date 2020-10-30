//
//  Constants.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum SFSymbol {
    
    static let arrow        = Image(systemName: "arrow.right")
    static let delete       = Image(systemName: "trash.fill")
    static let check        = Image(systemName: "checkmark")
    static let checkmark    = Image(systemName: "checkmark.circle.fill")
    static let rosette      = Image(systemName: "rosette")
    static let plus         = Image(systemName: "plus")
}


enum Emoji {
    
    static let deer     = Image("DeerEmoji")
}


enum HeaderButtonSymbol {
    
    case profile, close, back, settings, custom(AnyView)
            
    
    func get() -> Image {
        switch self {
        case .profile:  return Image("ProfileSymbol")
        case .close:    return Image("CloseSymbol")
        case .back:     return Image("BackSymbol")
        case .settings: return Image("SettingsSymbol")
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
        case .continue: return SFSymbol.arrow
        case .save:     return SFSymbol.check
        case .delete:   return SFSymbol.delete
        }
    }
}
