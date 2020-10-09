//
//  Constants.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum SFSymbol {
    
    static let arrow    = Image(systemName: "arrow.right")
    static let delete   = Image(systemName: "trash.fill")
    static let check    = Image(systemName: "checkmark")
    static let rosette  = Image(systemName: "rosette")
    static let plus     = Image(systemName: "plus")
}


enum Emoji {
    
    static let deer     = Image("DeerEmoji")
}


enum HeaderButtonSymbol {
    
    case profile, close, back, settings
            
    
    func get() -> Image {
        switch self {
        case .profile:  return Image("ProfileSymbol")
        case .close:    return Image("CloseSymbol")
        case .back:     return Image("BackSymbol")
        case .settings: return Image("SettingsSymbol")
        }
    }
}


@objc
enum MountainImage: Int16, CaseIterable {
    
    case mountain0 = 0
    case mountain1 = 1
    case mountain2 = 2
    
    
    func get() -> Image {
        switch self {
        case .mountain0: return Image("Mountain0")
        case .mountain1: return Image("Mountain1")
        case .mountain2: return Image("Mountain2")
        }
    }
    
    
    func getName() -> (top: String, bottom: String) {
        switch self {
        case .mountain0: return ("Mount", "Everest")
        case .mountain1: return ("Mount", "Tyll")
        case .mountain2: return ("St.", "Arlberg")
        }
    }
}

