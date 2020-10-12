//
//  DataModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

final class DataModel: ObservableObject {
    
    static let shared = DataModel()
    private let dataManager = DataManager.defaults
    
    private init() {
        fetchAllActiveGoals()
        fetchAllReachedGoals()
    }
    
    
    //Data
    
    @Published var activeGoals: [Goal] = []
    @Published var reachedGoals: [Goal] = []
    
    
    //Fetch
    
    private func fetchAllActiveGoals() {
        activeGoals = dataManager.fetchGoals(for: .active)
    }
    
    
    private func fetchAllReachedGoals() {
        reachedGoals = dataManager.fetchGoals(for: .reached)
    }
    
    
    //Insert
    
    func createGoal(with changeData: Goal.ChangeData) -> Bool {
        guard !GoalErrorHandler.hasErrors(with: changeData) else { return false }
        
        dataManager.insertGoal(with: changeData)
        fetchAllActiveGoals()
        return true
    }
    
    
    //Change
    
    func moveGoals() {
        for goal in activeGoals {
            dataManager.changeGoalOrder(goal, with: goal.sortOrder)
        }
    }
}
