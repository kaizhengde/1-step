//
//  GoalContentActiveView.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct GoalsActiveView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var dataModel = DataModel.shared
    @EnvironmentObject var goalModel: GoalModel
    @ObservedObject var viewModel: GoalsActiveModel
    
    
    var body: some View {
        LazyVGrid(columns: viewModel.goalItemColumns, spacing: 24) {
            ForEach(dataModel.activeGoals, id: \.self) { goal in
                GoalItem(goalActiveModel: viewModel, goal: goal) {
                    goalModel.selectedGoal = goal
                    mainModel.toGoalScreen()
                }
                .onDrag { viewModel.onGoalDrag(goal) }
                .onDrop(of: viewModel.dropType, delegate: GoalsActiveModel.DragAndDropDelegate(gridItems: $dataModel.activeGoals, current: $viewModel.currentDragItem, item: goal))
                .onAppear { viewModel.initItemTransition(of: Int(goal.sortOrder)) }
                .opacity(viewModel.itemsOpacityTransition(of: goal))
                .scaleEffect(viewModel.itemsScaleTransition(of: goal))
            }
            VStack {
                GoalCreateItem()
                    .onAppear { viewModel.initItemTransition(of: dataModel.activeGoals.count) }
                    .opacity(viewModel.createItemOpacityTransition())
                Spacer()
            }
            .frame(height: GoalItemArt.height)
        }
        .animation(viewModel.itemsAnimation())
    }
}
