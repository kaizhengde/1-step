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
    
    
    func get() -> Color {
        switch self {
        case .user0: return Color("User0")
        case .user1: return Color("User1")
        case .user2: return Color("User2")
        case .user3: return Color("User3")
        }
    }
}
