//
//  GoalEditModel.swift
//  1 Step
//
//  Created by Kai Zheng on 18.10.20.
//

import SwiftUI

final class GoalEditModel: ObservableObject, GoalSelectMountainDelegate, GoalEnterInputDelegate {
    
    @Published var selectedMountainData: GoalSelectMountainData = (nil, .user0)
    @Published var selectedEnterInputData = GoalEnterInputData()
    
    func dismissGoalSelectMountainView() {}
    
    
    func trySaveEditAndDismiss(_ goal: Goal) {
        let baseData: Goal.BaseData = (
            name:           	selectedEnterInputData.goalName.removeWhiteSpaces(),
            stepUnit:       	selectedEnterInputData.stepUnit,
            customUnit:         selectedEnterInputData.customUnit,
            neededStepUnits:    Int16(selectedEnterInputData.neededStepUnits),
            mountain:           selectedMountainData.mountain,
            color:              selectedMountainData.color
        )
        
        DataModel.shared.editGoal(goal, with: baseData) {
            if $0 { SheetManager.shared.dismiss() }
        }
    }
    
    
    func tryDelete(_ goal: Goal) {
        GoalDeleteHandler.confirmDelete(with: goal)
    }
    
    
    func deleteGoalAndDismiss(_ goal: Goal) {
        DataModel.shared.deleteGoal(goal) {
            if $0 {
                MainModel.shared.toScreen(.goals)
                SheetManager.shared.dismiss()
            }
        }
    }
}
