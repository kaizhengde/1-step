//
//  JourneyView.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

struct JourneyView: View {
    
    @EnvironmentObject var goalModel: GoalModel
    
    var milestonesUI: [Milestone] {
        Array(goalModel.selectedGoal.milestones)
            .sorted { $0.neededStepUnits > $1.neededStepUnits }
            .filter { $0.image != .summit }
    }
    
    var summitMilestone: Milestone {
        goalModel.selectedGoal.milestones.filter { $0.image == .summit }.first!
    }
    
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .progressStartAlignment)) {
            LazyVStack(spacing: 60) {
                MilestoneViewGroup(milestone: .constant(summitMilestone)) {
                    SummitMilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(summitMilestone))
                }
                .padding(.bottom, 20)
                
                ForEach(milestonesUI, id: \.self) { milestone in
                    if milestone == milestonesUI.last! {
                        MilestoneViewGroup(milestone: .constant(milestone)) {
                            MilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(milestone))
                        }
                        .alignmentGuide(.progressStartAlignment) { $0[.bottom] }
                    } else {
                        MilestoneViewGroup(milestone: .constant(milestone)) {
                            MilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(milestone))
                        }
                    }
                }
            }
            
            JourneyProgressView(goal: $goalModel.selectedGoal)
                .zIndex(1)
                .alignmentGuide(.progressStartAlignment) { $0[.bottom] }
        }
        .onAppear { print("app")}
        .onDisappear { print("dis")}
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @EnvironmentObject var goalModel: GoalModel
        @Binding var milestone: Milestone
        
        let itemView: () -> Content
        
        
        var body: some View {
            ZStack(alignment: .init(horizontal: .center, vertical: .milestoneAlignment)) {
                if milestone.state == .current {
                    MilestoneView(goal: $goalModel.selectedGoal, milestone: $milestone)
                        .alignmentGuide(.milestoneAlignment) { $0[.top] }
                        .zIndex(0)
                }
                itemView()
                    .alignmentGuide(.milestoneAlignment) { $0[VerticalAlignment.center] }
                    .zIndex(2)
            }
        }
    }
}
