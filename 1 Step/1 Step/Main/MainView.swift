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
            mainModel.activeScreen.isScreen(.goals()) ?
            GoalsScreen()
                .opacity(mainModel.activeScreen.opacity)
            : nil
            
            mainModel.activeScreen.isScreen(.goalAdd()) ?
            GoalAddScreen()
                .opacity(mainModel.activeScreen.opacity)
            : nil
            
            mainModel.activeScreen.isScreen(.profile()) ?
            ProfileScreen()
                .opacity(mainModel.activeScreen.opacity)
            : nil
        }
    }
}
