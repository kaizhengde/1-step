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
    @StateObject private var journeyAddStepsHandler = JourneyAddStepsHandler.shared
        
    
    var body: some View {
        VStack(spacing: 40) {
            StepsMap(viewModel: viewModel)
            MilestoneProgressView(viewModel: viewModel)
        }
        .padding(.top, viewModel.milestone.image == .summit ? 150 : 100)
        .padding(.bottom, 50)
        .frame(maxWidth: .infinity, maxHeight: journeyAddStepsHandler.milestoneChangeState == .closeFinished ? 0 : .infinity)
        .background(viewModel.goal.color.get(.dark))
        .cornerRadius(20)
        .padding(.horizontal, Layout.firstLayerPadding)
        .padding(.bottom, 20)
        .onChange(of: goalModel.selectedGoal.currentSteps) { _ in viewModel.updateMarkViewsAmount() }
    }
    
    
    private struct StepsMap: View {
        
        @ObservedObject var viewModel: MilestoneModel
        @StateObject private var journeyAddStepsHandler = JourneyAddStepsHandler.shared
        
        @State private var animate = false
        
        
        var body: some View {
            VStack(spacing: 40) {
                ForEach(0..<viewModel.markViewsAmount, id: \.self) { i in
                    Group {
                        if i == viewModel.markViewsAmount-1 {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animate ? 76 : 0)
                                .opacity(animate ? 0.0 : 1.0)
                        } else {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animate ? 76 : 0)
                        }
                    }
                    .animation(animate ? .oneSAnimation() : nil)
                }
            }
            .onReceive(journeyAddStepsHandler.normalAdd) {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { animate = false }
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
