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
    @StateObject private var goalsGridModel = GoalsGridModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GoalsHeaderView(goalsModel: goalsModel)
                
                if goalsModel.currentTab.isActive {
                    GoalsGridView(goalsModel: goalsModel, viewModel: goalsGridModel, selectedTab: .active)
                } else {
                    GoalsGridView(goalsModel: goalsModel, viewModel: goalsGridModel, selectedTab: .reached)
                }
            }
            .frame(width: Layout.firstLayerWidth)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, goalsModel.scrollViewBottomPadding)
            .animation(nil)
        }
        .offset(x: mainModel.currentScreen.active.isScreen(.goal(.transition)) ? -80 : 0)
        .onDrop(of: goalsGridModel.dropType, delegate: GoalsGridModel.DropOutsideDelegate(current: $goalsGridModel.currentDragItem))
        .onChange(of: goalsModel.currentTab) { _ in goalsGridModel.resetTransition() }
    }
}
