//
//  HiddenView.swift
//  1 Step
//
//  Created by Kai Zheng on 27.10.20.
//

import SwiftUI

struct HiddenView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var addStepAnimationHandler = AddStepAnimationHandler.shared
    @ObservedObject var viewModel: AddStepModel
    
    @State private var hide = false
    
    
    var body: some View {
        HiddenRectangle(viewModel: viewModel)
            .offset(x: viewModel.dragState == .show ? -50 : viewModel.dragOffset)
            .scaleEffect(y: viewModel.dragHiddenScaleEffect)
            .offset(x: goalModel.noDrag ? (goalModel.selectedGoal.currentState == .reached ? 30 : (hide ? 30 : 0)) : 30)
            .opacity(viewModel.dragState == .show ? 0.0 : 1.0)
            .overlay(
                Group {
                    if goalModel.noDrag && !hide && goalModel.selectedGoal.currentState == .active {
                        Color.hidden
                            .frame(width: 100, height: 300)
                            .highPriorityGesture(viewModel.dragGesture)
                    }
                }
            )
            .alignmentGuide(.addStepAlignment) { d in d[.top] }
            .padding(8)
            .onChange(of: addStepAnimationHandler.milestoneChangeState) { hide = $0 != .none }
            .onReceive(MilestoneModel.progressCircleTapped) { viewModel.dragState = .show }
    }
    
    
    private struct HiddenRectangle: View {
        
        @ObservedObject var viewModel: AddStepModel
        @StateObject private var goalModel = GoalModel.shared
        @StateObject private var infiniteAnimationManager = InfiniteAnimationManager.shared
        
        
        var body: some View {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 140)
                .foregroundColor(viewModel.hiddenForegroundColor(viewModel.goal.color.light, viewModel.goal.color.dark ))
                .oneSShadow(opacity: 0.12, blur: 8)
                .offset(x: viewModel.animate ? -5 : 0)
                .scaleEffect(y: viewModel.animate ? 1.05 : 1.0)
        }
    }
}
