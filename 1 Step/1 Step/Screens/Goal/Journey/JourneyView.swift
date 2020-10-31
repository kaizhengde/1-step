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
                MilestoneViewGroup(milestone: summitMilestone) {
                    SummitMilestoneItem(goal: $goalModel.selectedGoal, milestone: summitMilestone)
                }
                .padding(.bottom, 20)
                
                ForEach(milestonesUI, id: \.self) { milestone in
                    MilestoneViewGroup(milestone: milestone) {
                        MilestoneItem(goal: $goalModel.selectedGoal, milestone: milestone)
                    }
                }
            }
        }
    }
    
    
    private struct MilestoneViewGroup<Content: View>: View {
        
        @EnvironmentObject var goalModel: GoalModel
        var milestone: Milestone
        
        @State private var appear = false 
        
        let itemView: () -> Content
        
        
        var body: some View {
            ZStack(alignment: .init(horizontal: .center, vertical: .milestoneAlignment)) {
                if milestone.state == .current {
                    MilestoneView(goal: $goalModel.selectedGoal, milestone: milestone)
                        .alignmentGuide(.milestoneAlignment) { $0[.top] }
                }
                itemView()
                    .alignmentGuide(.milestoneAlignment) { $0[VerticalAlignment.center] }
            }
            .scaleEffect(appear ? 1.0 : 0.9)
            .opacity(appear ? 1.0 : 0.0)
            .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { self.appear = true } }
        }
    }
}
