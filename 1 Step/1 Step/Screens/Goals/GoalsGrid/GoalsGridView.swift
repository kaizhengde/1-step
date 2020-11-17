//
//  GoalsGridView.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct GoalsGridView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var dataModel = DataModel.shared
    @StateObject private var goalModel = GoalModel.shared
    @ObservedObject var goalsModel: GoalsModel
    @ObservedObject var viewModel: GoalsGridModel
    
    let selectedTab: GoalsTab
    
    
    var body: some View {
        LazyVGrid(columns: viewModel.goalItemColumns, spacing: 24) {
            ForEach(selectedTab.isActive ? dataModel.activeGoals : dataModel.reachedGoals, id: \.self) { goal in
                GoalItem(goalsGridModel: viewModel, goal: .constant(goal)) {
                    if selectedTab.isActive {
                        goalModel.selectedGoal = goal
                        mainModel.toGoalScreen()
                    } else {
                        
                    }
                }
                .onDrag { viewModel.onGoalDrag(goal) }
                .onDrop(of: viewModel.dropType, delegate: GoalsGridModel.DragAndDropDelegate(gridItems: selectedTab.isActive ? $dataModel.activeGoals : $dataModel.reachedGoals, current: $viewModel.currentDragItem, item: goal))
                .onAppear { viewModel.initItemTransition(of: Int(goal.sortOrder)) }
                .opacity(viewModel.itemsOpacityTransition(of: goal))
                .scaleEffect(viewModel.itemsScaleTransition(of: goal))
            }
            
            if selectedTab.isActive {
                VStack {
                    GoalCreateItem()
                        .onAppear { viewModel.initItemTransition(of: dataModel.activeGoals.count) }
                        .opacity(viewModel.createItemOpacityTransition())
                    Spacer()
                }
                .frame(height: GoalItemArt.height)
            }
        }
        .animation(viewModel.itemsAnimation())
    }
}
