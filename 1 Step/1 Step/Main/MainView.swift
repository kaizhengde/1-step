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
            mainModel.screen(.goal(.transition)) { GoalTransitionView() }
            mainModel.screen(.goal(.appear)) { GoalScreen() }
            mainModel.screen(.goalAdd) { GoalCreateScreen() }
            mainModel.screen(.profile) { ProfileScreen() }
        }
        .oneSOpacityAnimation()
        .sheet(isPresented: $sheetManager.appear, content: sheetManager.content)
        .oneSMiniSheet()
        .oneSPopup()
        .oneSFloater()
    }
}
