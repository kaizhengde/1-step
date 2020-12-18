//
//  GoalsGridView.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

struct GoalsGridView: View {
    
    @StateObject private var dataModel = DataModel.shared
    @ObservedObject var viewModel: GoalsGridModel
        
    
    var body: some View {
        LazyVGrid(columns: viewModel.goalItemColumns, spacing: 24) {
            ForEach(viewModel.goals, id: \.self) { goal in
                GoalItem(goalsGridModel: viewModel, goal: .constant(goal)) { viewModel.itemTapped(of: goal) }
                    .onDrag { viewModel.onGoalDrag(goal) }
                    .onDrop(of: viewModel.dropType, delegate: GoalsGridModel.DragAndDropDelegate(gridItems: viewModel.tab.isActive ? $dataModel.activeGoals : $dataModel.reachedGoals, current: $viewModel.currentDragItem, item: goal))
                    .onAppear { viewModel.initItemTransition(of: Int(goal.sortOrder)) }
                    .oneSItemTransition(viewModel.itemsTransition(of: goal))
            }
            
            if viewModel.tab.isActive {
                VStack {
                    GoalCreateItem()
                        .onAppear { viewModel.initItemTransition(of: dataModel.activeGoals.count+1) }
                        .oneSItemTransition(viewModel.createItemTransition())
                    Spacer()
                }
                .frame(height: GoalItemArt.height)
            }
        }
        .animation(viewModel.itemsAnimation())
    }
}
