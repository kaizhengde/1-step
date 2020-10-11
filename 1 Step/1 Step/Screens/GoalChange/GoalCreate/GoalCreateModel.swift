//
//  GoalAddModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI
import Combine

enum GoalCreateStage {
    case selectMountain, enterInput
}


final class GoalCreateModel: ObservableObject, GoalSelectMountainDelegate, GoalEnterInputDelegate {
    
    @Published var goalCreateStage: GoalCreateStage = .selectMountain
    
    @Published var selectedMountainData: GoalSelectMountainData = (nil, .user0)
    @Published var selectedEnterInputData = GoalEnterInputData()
    
    
    func dismissGoalSelectMountainView() {
        goalCreateStage = .enterInput
    }
    
    //MARK: - Transition
    
    var backButtonOpacity: Double { goalCreateStage == .enterInput ? 1.0 : 0.0 }
    
    
    //MARK: - Self
    
    func tryCreateGoalAndDismiss() {
        let changeData: Goal.ChangeData = (
            name:           selectedEnterInputData.goalName.trimmingCharacters(in: .whitespaces),
            stepCategory:   selectedEnterInputData.stepCategory,
            stepUnit:       selectedEnterInputData.stepUnit,
            stepCustomUnit: selectedEnterInputData.stepCustomUnit.trimmingCharacters(in: .whitespaces),
            stepsNeeded:    Int16(selectedEnterInputData.stepsNeeded),
            mountain:       selectedMountainData.mountain,
            color:          selectedMountainData.color
        )
        
        if DataModel.shared.createGoal(with: changeData) {
            MainModel.shared.toScreen(.goals)
        }
    }
}


