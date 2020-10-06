//
//  MainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct Screen {
    
    enum Active {
        case goals, goal, goalAdd, profile
        
        func isScreen(_ screen: Self) -> Bool { return self == screen }
    }
    
    
    var active: Active
    var opacity: Double = 1.0
    
    
    mutating func dismiss() { opacity = 0.0 }
    mutating func show() { opacity = 1.0 }
}


class MainModel: ObservableObject {
    
    static let shared = MainModel()
    private init() {} 
    
    @Published private(set) var screen: Screen = Screen(active: .goals)
    
    
    func toScreen(_ nextScreen: Screen.Active, withDelay: Bool = true) {
        screen.dismiss()
        
        let delay: DispatchTime = .now() + (withDelay ? 0.3 : 0)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.screen.active = nextScreen
            self.screen.show()
        }
    }
}



