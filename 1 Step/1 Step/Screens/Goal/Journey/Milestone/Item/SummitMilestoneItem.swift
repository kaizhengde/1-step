//
//  SummitMilestoneItem.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

struct SummitMilestoneItem: View {
        
    @Binding var appear: Bool
    
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
        
    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: goal, milestone: milestone)
                .oneSItemScaleTapGesture()
            
            VStack(spacing: 20) {
                MilestoneDotView(milestoneAppear: $appear, milestone: milestone, appearAfter: .milliseconds(400))
                MilestoneDotView(milestoneAppear: $appear, milestone: milestone, appearAfter: .milliseconds(600), showEndDate: false)
            }
        }
    }
    
    
    private struct ItemView: View {
        
        var goal: Goal
        var milestone: Milestone
        
        
        var body: some View {
            VStack(spacing: 10) {
                milestone.image.image
                    .font(.system(size: 50, weight: .thin))
                    .foregroundColor(.backgroundStatic)
                    .padding(.bottom, 30)

                OneSSecondaryHeaderText(text: Localized.summit, color: .backgroundStatic)

                HStack {
                    Spacer()
                    Text(milestone.neededStepUnits.toUI())
                        .font(.custom(Raleway.regular.weight, size: 18))
                    +
                    Text(" ").font(.system(size: 5))
                    +
                    Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                        .font(.custom(Raleway.regular.weight, size: 14))
                    Spacer()
                }
                .foregroundColor(.backgroundStatic)                
            }
            .padding(8)
            .frame(width: 170, height: 280)
            .modifier(MilestoneModel.MilestoneItemModifier(milestone: milestone))
        }
    }
}


