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
        ZStack {
            VStack(spacing: 60) {
                ZStack(alignment: .top) {
                    if summitMilestone.state == .current {
                        MilestoneView(goal: $goalModel.selectedGoal)
                    }
                    SummitMilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(summitMilestone))
                }
                .padding(.bottom, 20)
                
                ForEach(milestonesUI, id: \.self) { milestone in
                    ZStack(alignment: .top) {
                        if milestone.state == .current {
                            MilestoneView(goal: $goalModel.selectedGoal)
                        }
                        MilestoneItem(goal: $goalModel.selectedGoal, milestone: .constant(milestone))
                    }
                }
            }
            
            #warning("ProgressView")
        }
    }
}
