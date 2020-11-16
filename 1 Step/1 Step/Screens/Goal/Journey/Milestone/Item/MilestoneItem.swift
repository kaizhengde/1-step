//
//  MilestoneItem.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

struct MilestoneItem: View {
    
    @Binding var appear: Bool
    @StateObject private var journeyAddStepsHandler = JourneyAddStepsHandler.shared
        
    var milestone: Milestone
    var goal: Goal { milestone.parentGoal }
    
    @State private var tapAnimation: Bool = false

    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: goal, milestone: milestone)
                .scaleEffect(tapAnimation ? 1.05 : 1.0)
                .onTapGesture {
                    tapAnimation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
                }
            
            MilestoneDotView(milestoneAppear: $appear, milestone: milestone, appearAfter: .milliseconds(400))
        }
        .opacity(milestone.state == .done && journeyAddStepsHandler.hideDoneMilestoneItems ? 0.0 : 1.0)
    }
    
    
    private struct ItemView: View {
        
        var goal: Goal
        var milestone: Milestone
        
        
        var body: some View {
            VStack(spacing: 10) {
                milestone.image.get()
                    .font(.system(size: 50, weight: .ultraLight))
                    .foregroundColor(.backgroundToGray)
                
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
                .foregroundColor(.backgroundToGray)
            }
            .padding(8)
            .frame(width: milestone.state == .done ? 230 : 140, height: 160)
            .modifier(MilestoneModel.MilestoneItemModifier(milestone: milestone))
        }
    }
}

