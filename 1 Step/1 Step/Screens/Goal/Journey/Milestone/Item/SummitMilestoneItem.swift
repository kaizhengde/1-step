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
    
    @State private var tapAnimation: Bool = false
    
    
    var body: some View {
        VStack(spacing: 40) {
            ItemView(goal: goal, milestone: milestone)
                .scaleEffect(tapAnimation ? 1.05 : 1.0)
                .onTapGesture {
                    tapAnimation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { tapAnimation = false }
                }
            
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
                Group {
                    if milestone.image.isCustom {
                        milestone.image.get()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    } else {
                        milestone.image.get()
                            .font(.system(size: 50, weight: .ultraLight))
                    }
                }
                .foregroundColor(.backgroundToGray)
                .padding(.bottom, 30)
                
                OneSSecondaryHeaderText(text: "Summit", color: .backgroundToGray)
                
                HStack {
                    Spacer()
                    Text(milestone.neededStepUnits.toUI())
                        .font(.custom(Raleway.regular, size: 18))
                    +
                    Text(" ").font(.system(size: 5))
                    +
                    Text(goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description)
                        .font(.custom(Raleway.regular, size: 14))
                    Spacer()
                }
                .foregroundColor(.backgroundToGray)
            }
            .padding(8)
            .frame(width: 170, height: 280)
            .modifier(MilestoneModel.MilestoneItemModifier(milestone: milestone))
        }
    }
}


