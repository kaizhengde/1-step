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
            Color.whiteToDarkGray.edgesIgnoringSafeArea(.all)
            
            mainModel.screen(.goals) { GoalsScreen() }
            mainModel.screen(.goal(appear: false)) { GoalTransitionScreen() }
            mainModel.screen(.goal(appear: true)) { GoalScreen() }
            mainModel.screen(.goalAdd) { GoalCreateScreen() }
            mainModel.screen(.profile) { ProfileScreen() }
        }
        .oneSOpacityAnimation()
        .oneSMiniSheet()
        .oneSPopup()
        .oneSFloater()
    }
}
