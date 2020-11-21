//
//  MilestoneItem.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

struct MilestoneItem: View {
    
    @Binding var appear: Bool
    @StateObject private var addStepAnimationHandler = AddStepAnimationHandler.shared
        
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
    
    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: goal, milestone: milestone)
                .oneSItemTapScale()
            
            MilestoneDotView(milestoneAppear: $appear, milestone: milestone, appearAfter: .milliseconds(400))
        }
        .opacity(milestone.state == .done && addStepAnimationHandler.hideDoneMilestoneItems ? 0.0 : 1.0)
    }
    
    
    private struct ItemView: View {
        
        var goal: Goal
        var milestone: Milestone
        
        
        var body: some View {
            VStack(spacing: 10) {
                if milestone.image.isCustom {
                    milestone.image.get()
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .colorMultiply(.backgroundStatic)
                } else {
                    milestone.image.get()
                        .font(.system(size: 50, weight: .ultraLight))
                        .foregroundColor(.backgroundStatic)
                }
                
                HStack {
                    Spacer()
                    Text(milestone.neededStepUnits.toUI())
                        .font(.custom(Raleway.extraBold, size: 24))
                    +
                    Text(" ").font(.system(size: 5))
                    +
                    Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                        .font(.custom(Raleway.extraBold, size: 18))
                    Spacer()
                }
                .foregroundColor(.backgroundStatic)
            }
            .padding(8)
            .frame(width: milestone.state == .done ? 230 : 140, height: 160)
            .modifier(MilestoneModel.MilestoneItemModifier(milestone: milestone))
        }
    }
}

