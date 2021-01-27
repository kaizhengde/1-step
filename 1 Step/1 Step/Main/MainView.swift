//
//  MainView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var sheetManager = SheetManager.shared
    
    
    var body: some View {
        ZStack {
            Color.whiteToDarkGray.edgesIgnoringSafeArea(.all)
            
            mainModel.screen(.goals) { GoalsScreen() }
            mainModel.screen(.goalAdd) { GoalCreateScreen() }
            mainModel.screen(.firstStart) { FirstStartScreen() }
            mainModel.screen(.goal(.transition)) { GoalTransitionView() }
            mainModel.screen(.goal(.showActive)) { GoalScreen() }
            mainModel.screen(.goal(.showReached)) { GoalReachedScreen() }
            mainModel.screen(.profile) { ProfileScreen() }
        }
        .statusBar(hidden: true)
        .oneSOpacityAnimation()
        .oneSFullSheet()
        .sheet(isPresented: $sheetManager.appear, content: sheetManager.content)
        .oneSMiniSheet()
        .oneSPopup()
        .oneSConfetti()
        .oneSFloater()
        .oneSLoadingView()
        .oneSLockView()
        .onAppear { mainModel.considerUserDefaults() }
    }
}
