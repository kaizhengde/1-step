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
        
        var lowerBound = prevNeededSteps+1
        var upperBound = Int(milestone.neededSteps)
        
        if Int(goal.currentSteps) - prevNeededSteps > 3 {
            lowerBound = Int(goal.currentSteps)-3
        }
        
        if milestone.neededSteps - goal.currentSteps > 20 {
            upperBound = Int(goal.currentSteps)+20
        }
        
        for i in lowerBound..<upperBound {
            dictionary[i] = Double(i)/Double(goal.step.unitRatio)
        }
        return dictionary
    }
    
    var showLongMark: Bool { return milestone.neededSteps - goal.currentSteps > 20 }
    
    
    var body: some View {
        VStack(spacing: 40) {
            if showLongMark {
                StepLongMarkView(goal: $goal)
                    .padding(.bottom, 30)
            }
            
            ForEach(steps.sorted(by: >), id: \.key) { steps, stepUnits in
                if steps%(goal.step.unit == .hours ? 6 : 5) == 0 {
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
    
    
    private struct StepLongMarkView: View {
        
        @Binding var goal: Goal
        
        
        var body: some View {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 8, height: 120)
                .foregroundColor(goal.color.get(.light))
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
