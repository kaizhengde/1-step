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
    @StateObject private var addStepAnimationHandler = AddStepAnimationHandler.shared

    @State private var appear = false
    
    
    var body: some View {
        VStack(spacing: 40) {
            StepsMap(viewModel: viewModel)
            MilestoneProgressView(viewModel: viewModel)
        }
        .padding(.top, viewModel.milestone.image == .summit ? 150 : 100)
        .padding(.bottom, 50)
        .frame(maxWidth: .infinity, maxHeight: addStepAnimationHandler.hideMilestoneView ? 0 : (appear ? .infinity : 0))
        .background(viewModel.goal.color.dark)
        .cornerRadius(20)
        .padding(.horizontal, Layout.firstLayerPadding)
        .padding(.bottom, 20)
        .onChange(of: goalModel.selectedGoal.currentSteps) { _ in viewModel.updateMarkViewsAmount() }
        .onAppear { appear = true }
        .oneSAnimation()
    }
    
    
    private struct StepsMap: View {
        
        @StateObject private var goalModel = GoalModel.shared
        @StateObject private var addStepAnimationHandler = AddStepAnimationHandler.shared
        @ObservedObject var viewModel: MilestoneModel
        
        @State private var animateMarks = false
        @State private var forwardAdd = true
        
        
        var body: some View {
            VStack(spacing: 40) {
                ForEach(0..<viewModel.markViewsAmount, id: \.self) { i in
                    Group {
                        if i == 0 {
                            TopAndBottomStepMarkView(viewModel: viewModel, animateMarks: $animateMarks, forwardAdd: $forwardAdd, index: i)
                        } else if i == viewModel.markViewsAmount-1 {
                            TopAndBottomStepMarkView(viewModel: viewModel, animateMarks: $animateMarks, forwardAdd: $forwardAdd, index: i)
                        } else {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? (forwardAdd ? 76 : -76) : 0)
                        }
                    }
                    .animation(!goalModel.noDrag || animateMarks ? .oneSAnimation() : nil)
                }
            }
            .onReceive(addStepAnimationHandler.normalAdd) { forward in
                animateMarks = true
                forwardAdd = forward
                DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.oneS) { animateMarks = false }
            }
        }
        
        
        private struct TopAndBottomStepMarkView: View {
            
            @ObservedObject var viewModel: MilestoneModel
            @Binding var animateMarks: Bool
            @Binding var forwardAdd: Bool
            
            var index: Int
            var forward: Bool { index == 0 ? forwardAdd : !forwardAdd }
            var offset: CGFloat { index == 0 ? 76 : -76 }
            
            
            var body: some View {
                if viewModel.markViewsAmount == 1 {
                    if forward {
                        ZStack {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? 0 : -offset)
                                .opacity(animateMarks ? 1.0 : 0.0)
                            
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? offset : 0)
                                .opacity(animateMarks ? 0.0 : 1.0)
                        }
                    } else {
                        ZStack {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? 0 : offset)
                                .opacity(animateMarks ? 1.0 : 0.0)
                            
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? -offset : 0)
                                .opacity(animateMarks ? 0.0 : 1.0)
                        }
                    }
                } else {
                    if forward {
                        ZStack {
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? 0 : -offset)
                                .opacity(animateMarks ? 1.0 : 0.0)
                            
                            StepMarkView(goal: viewModel.goal)
                                .offset(y: animateMarks ? offset : 0)
                        }
                    } else {
                        StepMarkView(goal: viewModel.goal)
                            .offset(y: animateMarks ? -offset : 0)
                            .opacity(animateMarks ? 0.0 : 1.0)
                    }
                }
            }
        }
    
        
        private struct StepMarkView: View {
            
            var goal: Goal
            
            
            var body: some View {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .frame(width: 10, height: 36)
                    .foregroundColor(goal.color.light)
            }
        }
    }
}
