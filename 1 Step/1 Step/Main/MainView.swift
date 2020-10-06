//
//  MainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        ZStack {
            mainModel.screen.active.isScreen(.goals) ?
            GoalsScreen()
            : nil
            
            mainModel.screen.active.isScreen(.goalAdd) ?
            GoalAddScreen()
            : nil
            
            mainModel.screen.active.isScreen(.profile) ?
            ProfileScreen()
            : nil
        }
        .opacity(mainModel.screen.opacity)
        .animation(.easeInOut(duration: 0.3))
    }
}
