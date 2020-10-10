//
//  MountainImage.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

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
