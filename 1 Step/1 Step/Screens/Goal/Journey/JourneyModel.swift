//
//  JourneyModel.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI
import CoreData

class JourneyModel: ObservableObject {
        
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    var milestonesUI: [Milestone] {
        Array(goal.milestones)
            .sorted { $0.neededStepUnits > $1.neededStepUnits }
            .filter { $0.image != .summit }
    }
    
    var summitMilestone: Milestone {
        goal.milestones.filter { $0.image == .summit }.first!
    }
    
    var currentMilestone: Milestone {
        goal.milestones.filter { $0.state == .current }.first ?? Milestone(context: PersistenceManager.defaults.context)
    }
    
    var lastMilestone: Milestone {
        milestonesUI.last!
    }
}


