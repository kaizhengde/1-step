//
//  UserColor.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

@objc
enum UserColor: Int16 {
    
    case user0 = 0
    case user1 = 1
    case user2 = 2
    case user3 = 3
    
    enum UserColorArt {
        case normal, light, dark
    }
    
    
    func get(_ art: UserColorArt = .normal) -> Color {
        switch art {
        case .normal:
            switch self {
            case .user0: return Color("User0")
            case .user1: return Color("User1")
            case .user2: return Color("User2")
            case .user3: return Color("User3")
            }
        case .light:
            switch self {
            case .user0: return Color("User0Light")
            case .user1: return Color("User1Light")
            case .user2: return Color("User2Light")
            case .user3: return Color("User3Light")
            }
        case .dark:
            switch self {
            case .user0: return Color("User0Dark")
            case .user1: return Color("User1Dark")
            case .user2: return Color("User2Dark")
            case .user3: return Color("User3Dark")
            }
        }
    }
}
