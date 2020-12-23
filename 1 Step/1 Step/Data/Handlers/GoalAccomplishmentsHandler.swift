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
            avoidNegativeScores()
        }
        
        
        static func updateMilestonesAccomplishment(_ oldAmountReached: Int, _ newAmountReached: Int) {
            let newReached = newAmountReached - oldAmountReached
            UserDefaultsManager.shared.accomplishmentTotalMilestonesReached += newReached
            AppStoreManager.askToRateAfterReachingThreeMilestones()
            avoidNegativeScores()
        }
        
        
        static func updateGoalsAccomplishment(_ currentState: GoalState) {
            UserDefaultsManager.shared.accomplishmentTotalGoalsReached += (currentState == .reached) ? 1 : 0
            avoidNegativeScores()
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
            avoidNegativeScores()
        }
    }
    
    
    private static func avoidNegativeScores() {
        if UserDefaultsManager.shared.accomplishmentTotalSteps < 0 {
            UserDefaultsManager.shared.accomplishmentTotalSteps = 0
        }
        if UserDefaultsManager.shared.accomplishmentTotalMilestonesReached < 0 {
            UserDefaultsManager.shared.accomplishmentTotalMilestonesReached = 0
        }
        if UserDefaultsManager.shared.accomplishmentTotalGoalsReached < 0 {
            UserDefaultsManager.shared.accomplishmentTotalMilestonesReached = 0
        }
    }
    
    
    static func noAccomplishments() -> Bool {
        return UserDefaultsManager.shared.accomplishmentTotalSteps == 0
            && UserDefaultsManager.shared.accomplishmentTotalMilestonesReached == 0
            && UserDefaultsManager.shared.accomplishmentTotalGoalsReached == 0
    }
    
    
    static func resetAllAccomplishments() {
        UserDefaultsManager.shared.accomplishmentTotalSteps             = 0
        UserDefaultsManager.shared.accomplishmentTotalMilestonesReached = 0
        UserDefaultsManager.shared.accomplishmentTotalGoalsReached      = 0
    }
}
