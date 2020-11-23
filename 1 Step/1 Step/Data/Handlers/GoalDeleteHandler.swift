//
//  GoalDeleteHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import Foundation

struct GoalDeleteHandler {
    
    static func confirmDelete(with goal: Goal) {
        PopupManager.shared.showTextFieldConfirmationPopup(.goalDelete, titleText: "Delete", bodyText: "Are you sure?\n\nThis action cannot be undone.\nConfirm with your Goal.", textColor: .backgroundStatic, placeholder: "Your Goal", placeholderColor: .blackStatic, textLimit: Goal.nameDigitsLimit, confirmationText: goal.name, backgroundColor: .grayStatic)
    }
    
    
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
