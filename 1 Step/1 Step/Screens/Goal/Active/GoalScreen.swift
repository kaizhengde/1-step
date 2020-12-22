//
//  GoalScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

struct GoalScreen: View {
    
    @Environment(\.colorScheme) var appAppearance: ColorScheme
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var addStepModel = AddStepModel()
    @GestureState private var dragOffset: CGFloat = .zero

    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if !goalModel.noDrag {
                    GoalMenuView()
                }
                GoalView()
            }
            .highPriorityGesture(
                DragGesture()
                    .updating($dragOffset) { goalModel.updating($0, &$1, $2) }
                    .onEnded { goalModel.onEnded($0) }
            )
            .onChange(of: dragOffset) { goalModel.dragOffset = $0 }
            .onTapGesture { addStepModel.dragState = .hidden }
            
            AddStepView(viewModel: addStepModel)
        }
        .onAppear { goalModel.appear(with: appAppearance) }
        .onChange(of: appAppearance) { goalModel.updateAppearance(with: $0) }
        .oneSAnimation()
        .transition(.identity)
        .onReceive(PopupManager.shared.dismissed) { if $0 == .goalReached { goalModel.onDismissGoalCompletePopup() } }
    }
}


