//
//  MainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct Screen {
    
    enum Active: Equatable {
        
        case goals, goal(appear: Bool), goalAdd, profile

        func isScreen(_ screen: Self) -> Bool {
            switch screen {
            case .goals: return self == .goals || self == .goal(appear: false)
            case .goal(appear: true): return self == .goal(appear: true)
            case .goal(appear: false): return self == .goal(appear: false)
            case .goalAdd: return self == .goalAdd
            case .profile: return self == .profile
            }
        }
    }

    
    var active: Active = .goals
    var opacity: Double = 1.0

    mutating func dismiss() { opacity = 0.0 }
    mutating func show() { opacity = 1.0 }
}


final class MainModel: ObservableObject {
    
    static let shared = MainModel()
    private init() {} 
    
    @Published private(set) var currentScreen: Screen = Screen() 
    
    
    func toScreen(_ nextScreen: Screen.Active) {
        currentScreen.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DelayAfter.opacity) {
            self.currentScreen.active = nextScreen
            self.currentScreen.show()
        }
    }
    
    
    func screen<Content: View>(_ screen: Screen.Active, content: () -> Content) -> AnyView {
        if currentScreen.active.isScreen(screen) {
            if screen == .goal(appear: false) {
                return AnyView(content())
            } else {
                return AnyView(content().opacity(currentScreen.opacity))
            }
        }
        return AnyView(EmptyView())
    }
    
    
    func toGoalScreen() {
        currentScreen.active = .goal(appear: false)
        currentScreen.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DelayAfter.mountainAppear) {
            self.currentScreen.dismiss()
            self.currentScreen.active = .goal(appear: true)
            self.currentScreen.show()
        }
    }
}



