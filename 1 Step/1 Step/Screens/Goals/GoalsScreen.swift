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
    @StateObject private var goalsActiveGridModel = GoalsGridModel(tab: .active)
    @StateObject private var goalsReachedGridModel = GoalsGridModel(tab: .reached)
    
 
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                GoalsHeaderView(goalsModel: goalsModel)
                
                if goalsModel.currentTab.isActive {
                    GoalsGridView(viewModel: goalsActiveGridModel)
                } else {
                    GoalsGridView(viewModel: goalsReachedGridModel)
                }
            }
            .frame(width: Layout.firstLayerWidth)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, goalsModel.scrollViewBottomPadding)
            .animation(nil)
        }
        .offset(x: mainModel.currentScreen.active.isScreen(.goal(.transition)) ? -80 : 0)
        .onDrop(of: goalsActiveGridModel.dropType, delegate: GoalsModel.DropOutsideDelegate(current: goalsModel.currentTab.isActive ? $goalsActiveGridModel.currentDragItem : $goalsReachedGridModel.currentDragItem))
        .onChange(of: goalsModel.currentTab) { _ in 
            goalsActiveGridModel.resetTransition()
            goalsReachedGridModel.resetTransition()
        }
    }
}
