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
            //Background
            Color.whiteToDarkGray.edgesIgnoringSafeArea(.all)
            
            //Screens (one active only at a time)
            mainModel.screen(.goals) { GoalsScreen() }
            mainModel.screen(.goalAdd) { GoalAddScreen() }
            mainModel.screen(.profile) { ProfileScreen() }
        }
        .animation(.easeInOut(duration: AnimationDuration.screenOpacity))
    }
}
