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
    
    var steps: [Int: Double] {
        var dictionary: [Int: Double] = [:]
        
        let prevNeededSteps = Int(milestone.neededSteps-milestone.stepsFromPrev)
        
        for i in prevNeededSteps+1..<Int(milestone.neededSteps) {
            dictionary[i] = Double(i)/Double(goal.step.unitRatio)
        }
        return dictionary
    }
    
    
    var body: some View {
        VStack(spacing: 40) {
            ForEach(steps.sorted(by: >), id: \.key) { steps, stepUnits in
                if steps%5 == 0 {
                    StepTextMarkView(goal: $goal, stepUnitsNeeded: stepUnits.toUI())
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
            OneSText(text: stepUnitsNeeded, font: .custom(weight: Raleway.extraBold, size: 45), color: goal.color.get(.light))
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
