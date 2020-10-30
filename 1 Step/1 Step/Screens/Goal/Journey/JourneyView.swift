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
        VStack(spacing: 80) {
            SummitMilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(summitMilestone))
                .padding(.bottom, 50)
            
            ForEach(milestonesUI, id: \.self) { milestone in
                MilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(milestone))
            }
        }
        .padding(.bottom, 260*Layout.multiplierHeight)
    }
}
