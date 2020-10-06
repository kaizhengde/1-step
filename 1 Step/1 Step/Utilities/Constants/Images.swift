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



