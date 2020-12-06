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
        let baseData: Goal.BaseData = (
            name:               selectedEnterInputData.goalName.trimmingCharacters(in: .whitespaces),
            stepUnit:           selectedEnterInputData.stepUnit,
            customUnit:         selectedEnterInputData.customUnit,
            neededStepUnits:    Int16(selectedEnterInputData.neededStepUnits),
            mountain:           selectedMountainData.mountain,
            color:              selectedMountainData.color
        )
        
        DataModel.shared.createGoal(with: baseData) {
            MainModel.shared.toScreen(.goals)
        }
    }
    
    
    //MARK: - GoalInfo
    
    var goalInfoCurrent: GoalInfoCurrent = DataModel.shared.goals.count > 0 ? .examples : .howItWorks
}


