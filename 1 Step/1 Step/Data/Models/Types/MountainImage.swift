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
    
    
    var image: Image {
        switch self {
        case .mountain0: return Goal.mountain0
        case .mountain1: return Goal.mountain1
        case .mountain2: return Goal.mountain2
        }
    }
    
    
    var name: (top: String, bottom: String) {
        switch self {
        case .mountain0: return ("Prenzlauer", "Berg")
        case .mountain1: return ("Schöne", "Berg")
        case .mountain2: return ("Kreuz", "Berg")
        }
    }
}
