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
    
    @Published private(set) var currentScreen: Screen = Screen(active: .goals)
    
    
    func toScreen(_ nextScreen: Screen.Active, delay: DispatchTime = .now() + Duration.screenOpacity) {
        currentScreen.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.currentScreen.active = nextScreen
            self.currentScreen.show()
        }
    }
    
    
    func screen<Content: View>(_ screen: Screen.Active, content: () -> Content) -> some View {
        currentScreen.active.isScreen(screen) ?
        content()
            .opacity(currentScreen.opacity)
        : nil
    }
}



