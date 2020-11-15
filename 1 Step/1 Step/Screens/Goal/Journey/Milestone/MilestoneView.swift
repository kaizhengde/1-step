//
//  MilestoneView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneView: View {
    
    @StateObject private var goalModel = GoalModel.shared
    @StateObject private var viewModel = MilestoneModel()
        
    
    var body: some View {
        VStack(spacing: 40) {
            StepsMap(viewModel: viewModel)
            MilestoneProgressView(viewModel: viewModel)
        }
        .padding(.top, viewModel.milestone.image == .summit ? 150 : 100)
        .padding(.bottom, 50)
        .frame(maxWidth: .infinity, maxHeight: JourneyAnimationHandler.shared.milestoneChangeState == .closeFinished ? 0 : .infinity)
        .background(viewModel.goal.color.get(.dark))
        .cornerRadius(20)
        .padding(.horizontal, Layout.firstLayerPadding)
        .padding(.bottom, 20)
        .onChange(of: goalModel.selectedGoal.currentSteps) { _ in viewModel.updateMarkViewsAmount() }
    }
    
    
    private struct StepsMap: View {
        
        @ObservedObject var viewModel: MilestoneModel
        
        
        var body: some View {
            VStack(spacing: 40) {
                ForEach(0..<viewModel.markViewsAmount, id: \.self) { _ in
                    StepMarkView(goal: viewModel.goal)
                }
            }
        }
    
        
        private struct StepMarkView: View {
            
            var goal: Goal
            
            
            var body: some View {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .frame(width: 10, height: 36)
                    .foregroundColor(goal.color.get(.light))
            }
        }
    }
}
