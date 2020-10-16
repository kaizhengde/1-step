//
//  GoalContentActiveView.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI
import UniformTypeIdentifiers

struct GoalsActiveView: View {
    
    @StateObject private var dataModel = DataModel.shared
    @StateObject private var viewModel = GoalsActiveModel()
    
    
    var body: some View {
        LazyVGrid(columns: viewModel.goalItemColumns, spacing: 24) {
            ForEach(dataModel.activeGoals, id: \.self) { goal in
                GoalItem(goalActiveModel: viewModel, goal: goal) { print(goal.name) }
                    .onDrag { viewModel.onGoalDrag(goal) }
                    .onDrop(of: [UTType.text], delegate: GoalsActiveModel.DragRelocateDelegate(gridItems: $dataModel.activeGoals, current: $viewModel.currentDragItem, item: goal))
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
        }
        .animation(viewModel.itemsAnimation())
    }
}
