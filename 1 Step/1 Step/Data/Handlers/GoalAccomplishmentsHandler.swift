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
}
