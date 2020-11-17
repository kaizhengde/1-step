//
//  GoalsScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct GoalsScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var goalsModel = GoalsModel()
    @StateObject private var goalsActiveGridModel = GoalsGridModel()
    @StateObject private var goalsReachedGridModel = GoalsGridModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GoalsHeaderView(goalsModel: goalsModel)
                
                if goalsModel.currentTab.isActive {
                    GoalsGridView(goalsModel: goalsModel, viewModel: goalsActiveGridModel, selectedTab: .active)
                } else {
                    GoalsGridView(goalsModel: goalsModel, viewModel: goalsReachedGridModel, selectedTab: .reached)
                }
            }
            .frame(width: Layout.firstLayerWidth)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, goalsModel.scrollViewBottomPadding)
            .animation(nil)
        }
        .offset(x: mainModel.currentScreen.active.isScreen(.goal(.transition)) ? -80 : 0)
        .onDrop(of: goalsActiveGridModel.dropType, delegate: GoalsGridModel.DropOutsideDelegate(current: $goalsActiveGridModel.currentDragItem))
        .onDrop(of: goalsReachedGridModel.dropType, delegate: GoalsGridModel.DropOutsideDelegate(current: $goalsReachedGridModel.currentDragItem))
        .onChange(of: goalsModel.currentTab) {
            goalsActiveGridModel.resetTransition(with: $0)
            goalsReachedGridModel.resetTransition(with: $0)
        }
    }
}
