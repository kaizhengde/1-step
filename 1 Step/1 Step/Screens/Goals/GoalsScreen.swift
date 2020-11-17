//
//  GoalsScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @EnvironmentObject var goalsModel: GoalsModel
    @StateObject private var goalsActiveModel = GoalsActiveModel()
    @StateObject private var goalsReachedModel = GoalsReachedModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GoalsHeaderView()
                
                if goalsModel.currentTab == .active {
                    GoalsActiveView(viewModel: goalsActiveModel)
                } else {
                    GoalsReachedView(viewModel: goalsReachedModel)
                }
            }
            .frame(width: Layout.firstLayerWidth)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, goalsModel.scrollViewBottomPadding)
            .animation(nil)
        }
        .offset(x: mainModel.currentScreen.active.isScreen(.goal(.transition)) ? -80 : 0)
        .onDrop(of: goalsActiveModel.dropType, delegate: GoalsActiveModel.DropOutsideDelegate(current: $goalsActiveModel.currentDragItem))
        .onChange(of: goalsModel.currentTab) {
            if $0 == .reached { goalsActiveModel.resetTransition() }
        }
    }
}
