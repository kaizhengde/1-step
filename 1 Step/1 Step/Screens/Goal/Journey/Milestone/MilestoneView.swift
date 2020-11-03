//
//  MilestoneView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    @StateObject private var viewModel: MilestoneModel
    
    var milestone: Milestone
    
    init(milestone: Milestone) {
        self.milestone = milestone
        _viewModel = StateObject(wrappedValue: MilestoneModel(goal: milestone.parentGoal, milestone: milestone))
    }
    
    
    var body: some View {
        StepsMap(viewModel: viewModel)
            .padding(.top, viewModel.milestone.image == .summit ? 150 : 100)
            .padding(.bottom, 80)
            .frame(maxWidth: .infinity)
            .background(viewModel.goal.color.get(.dark))
            .cornerRadius(20)
            .padding(.horizontal, Layout.firstLayerPadding)
            .padding(.bottom, 20)
            .onChange(of: goalModel.selectedGoal) {
                viewModel.goal = $0!
            }
            .onChange(of: viewModel.goal.currentSteps) { _ in
                print("3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    print("4")
                    viewModel.updateStepsMap()
                }
            }
    }
    
    
    private struct StepsMap: View {
        
        @ObservedObject var viewModel: MilestoneModel
        
        
        var body: some View {
            VStack(spacing: 40) {
                if viewModel.showLongMark {
                    StepLongMarkView(goal: viewModel.goal)
                        .padding(.bottom, 30)
                }
                
                ForEach(viewModel.stepsDic.sorted(by: >), id: \.key) { steps, stepUnits in
                    if steps > viewModel.goal.currentSteps && steps%(viewModel.goal.step.unit == .hours ? 6 : 5) == 0 {
                        StepTextMarkView(goal: viewModel.goal, stepUnitsNeeded: stepUnits.toUI())
                    } else {
                        if steps == viewModel.goal.currentSteps {
                            StepMarkView(goal: viewModel.goal)
                                .background(JourneyModel.StepVS())
                        } else {
                            StepMarkView(goal: viewModel.goal)
                        }
                    }
                }
            }
        }
        
        
        private struct StepTextMarkView: View {
            
            var goal: Goal
            let stepUnitsNeeded: String
            
            
            var body: some View {
                OneSText(text: stepUnitsNeeded, font: .custom(weight: Raleway.extraBold, size: 45), color: goal.color.get(.light))
            }
        }
        
        
        private struct StepLongMarkView: View {
            
            var goal: Goal
            
            
            var body: some View {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 8, height: 120)
                    .foregroundColor(goal.color.get(.light))
            }
        }
        
        
        private struct StepMarkView: View {
            
            var goal: Goal
            
            
            var body: some View {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 8, height: 32)
                    .foregroundColor(goal.color.get(.light))
            }
        }
    }
}
