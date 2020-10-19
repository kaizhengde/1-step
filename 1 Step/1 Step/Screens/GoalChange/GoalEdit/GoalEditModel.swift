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
        let changeData: Goal.ChangeData = (
            name:           selectedEnterInputData.goalName.trimmingCharacters(in: .whitespaces),
            stepCategory:   selectedEnterInputData.stepCategory,
            stepUnit:       selectedEnterInputData.stepUnit,
            stepCustomUnit: selectedEnterInputData.stepCustomUnit.trimmingCharacters(in: .whitespaces),
            stepsNeeded:    Int16(selectedEnterInputData.stepsNeeded),
            mountain:       selectedMountainData.mountain,
            color:          selectedMountainData.color
        )
        
        if DataModel.shared.editGoal(goal, with: changeData) {
            SheetManager.shared.dismiss()
        }
    }
    
    
    func deleteGoalAndDismiss(_ goal: Goal) {
        DataModel.shared.deleteGoal(goal)
        
        MainModel.shared.toScreen(.goals)
        SheetManager.shared.dismiss()
    }
}
