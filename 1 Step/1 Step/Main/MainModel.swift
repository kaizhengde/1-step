//
//  MainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

class MainModel: ObservableObject {
    
    static let shared = MainModel()
    private init() {} 
    
    @Published private(set) var activeScreen: ActiveScreen = .goals()
    
    
    func toScreen(_ screen: ActiveScreen, withDismiss: Bool) {
        if withDismiss {
            activeScreen.dismiss()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.activeScreen = screen
            }
        } else {
            self.activeScreen = screen
        }
    }
}


enum ActiveScreen {
    
    case goals(Bool = true)
    case goal(Bool = true)
    case goalAdd(Bool = true)
    case profile(Bool = true)
    
    
    var opacity: Double {
        var show = false
        
        switch self {
        case let .goals(s): show = s
        case let .goal(s): show = s
        case let .goalAdd(s): show = s
        case let .profile(s): show = s
        }
        
        return show ? 1.0 : 0.0
    }
    
    
    func isScreen(_ screen: ActiveScreen) -> Bool {
        return self ~= screen
    }
    
    
    mutating func dismiss() {
        switch self {
        case .goals(_):     self = .goals(false)
        case .goal(_):      self = .goal(false)
        case .goalAdd(_):   self = .goalAdd(false)
        case .profile(_):   self = .profile(false)
        }
    }
}


extension ActiveScreen: EnumTypeEquatable {
    static func ~=(lhs: ActiveScreen, rhs: ActiveScreen) -> Bool {
        switch (lhs, rhs) {
        case (.goals, .goals), (.goal, .goal), (.goalAdd, .goalAdd), (.profile, .profile): return true
        default: return false
        }
    }
}
