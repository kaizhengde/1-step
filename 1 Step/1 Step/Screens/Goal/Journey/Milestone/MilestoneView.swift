//
//  MilestoneView.swift
//  1 Step
//
//  Created by Kai Zheng on 31.10.20.
//

import SwiftUI

struct MilestoneView: View {
    
    @Binding var goal: Goal
    @Binding var milestone: Milestone
    
    
    var body: some View {
        VStack(spacing: 40) {
            ForEach(Int(milestone.stepsFromPrev)..<Int(milestone.neededSteps)) {
                if $0%5 == 0 {
                    StepTextMarkView(goal: $goal, stepUnitsNeeded: "\($0)")
                } else {
                    StepMarkView(goal: $goal)
                }
            }
        }
        .padding(.top, milestone.image == .summit ? 150 : 100)
        .padding(.bottom, 80)
        .frame(maxWidth: .infinity)
        .background(goal.color.get(.dark))
        .cornerRadius(20)
        .padding(.horizontal, Layout.firstLayerPadding)
        .padding(.bottom, 20)
    }
    
    
    private struct StepTextMarkView: View {
        
        @Binding var goal: Goal
        let stepUnitsNeeded: String
        
        
        var body: some View {
            OneSText(text: stepUnitsNeeded, font: .custom(weight: Raleway.extraBold, size: 50), color: goal.color.get(.light))
        }
    }
    
    
    private struct StepMarkView: View {
        
        @Binding var goal: Goal
        
        
        var body: some View {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 8, height: 32)
                .foregroundColor(goal.color.get(.light))
        }
    }
}
