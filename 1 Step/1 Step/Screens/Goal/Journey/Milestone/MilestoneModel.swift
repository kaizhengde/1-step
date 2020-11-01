//
//  MilestoneModel.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

class MilestoneModel: ObservableObject {
    
    @Published var goal: Goal
    var milestone: Milestone
    
    
    init(goal: Goal, milestone: Milestone) {
        self.goal = goal
        self.milestone = milestone 
    }
    
    
    var stepsDic: [Int: Double] {
        var dictionary: [Int: Double] = [:]
        
        let prevNeededSteps = Int(milestone.neededSteps-milestone.stepsFromPrev)
        
        var lowerBound = prevNeededSteps
        var upperBound = Int(milestone.neededSteps)
        
        if Int(goal.currentSteps) - prevNeededSteps > 3 {
            lowerBound = Int(goal.currentSteps)-3
        }
        
        if milestone.neededSteps - goal.currentSteps > 12 {
            upperBound = Int(goal.currentSteps)+12
        }
        
        for i in lowerBound..<upperBound {
            dictionary[i] = Double(i)/Double(goal.step.unitRatio)
        }
        return dictionary
    }
    
    var showLongMark: Bool { milestone.neededSteps - goal.currentSteps > 20 }
    
    
    //MARK: - Milestone Item
    
    struct MilestoneItemModifier: ViewModifier {
        
        var milestone: Milestone
        var goal: Goal { milestone.parentGoal }
        
        func body(content: Content) -> some View {
            content
                .background(goal.color.get(milestone.state == .active ? .dark : .light))
                .cornerRadius(8)
                .contentShape(Rectangle())
                .oneSShadow(opacity: 0.15, y: 3, blur: 10)
                .overlay(
                    Group {
                        if milestone.state == .done {
                            VStack {
                                HStack {
                                    Spacer()
                                    SFSymbol.checkmark
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(goal.color.get(.dark))
                                        .padding(20)
                                }
                                Spacer()
                            }
                        }
                    }
                )
        }
    }
}
