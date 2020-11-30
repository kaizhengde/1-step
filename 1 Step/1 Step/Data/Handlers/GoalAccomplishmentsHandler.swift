//
//  GoalAccomplishmentsHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import SwiftUI

enum GoalAccomplishmentsHandler {
    
    enum AddSteps {
        static func updateStepsAccomplishment(_ oldCurrentSteps: Int16, _ newCurrentSteps: Int16) {
            UserDefaultsManager.shared.accomplishmentTotalSteps += Int(newCurrentSteps - oldCurrentSteps)
        }
        
        
        static func updateMilestonesAccomplishment(_ oldAmountReached: Int, _ newAmountReached: Int) {
            let newReached = newAmountReached - oldAmountReached
            UserDefaultsManager.shared.accomplishmentTotalMilestonesReached += newReached
        }
        
        
        static func updateGoalsAccomplishment(_ currentState: GoalState) {
            UserDefaultsManager.shared.accomplishmentTotalGoalsReached += (currentState == .reached) ? 1 : 0
        }
    }
    
    
    enum Delete {
        static func updateAccomplishments(with goal: Goal) {
            if goal.currentState == .active {
                let reachedMilestones = goal.milestones.reduce(0) { $0 + ($1.state == .done ? 1 : 0) }
                
                UserDefaultsManager.shared.accomplishmentTotalSteps             -= Int(goal.currentSteps)
                UserDefaultsManager.shared.accomplishmentTotalMilestonesReached -= reachedMilestones
            } else {
                UserDefaultsManager.shared.accomplishmentTotalSteps             -= Int(goal.neededSteps)
                UserDefaultsManager.shared.accomplishmentTotalMilestonesReached -= Int(goal.milestones.count)
                UserDefaultsManager.shared.accomplishmentTotalGoalsReached      -= 1
            }
        }
    }
}
