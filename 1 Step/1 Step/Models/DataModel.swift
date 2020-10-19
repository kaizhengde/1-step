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
    
    private init() { fetchAllGoals() }
    
    
    //MARK: - Data
    
    @Published var activeGoals: [Goal] = []
    @Published var reachedGoals: [Goal] = []
    
    
    //MARK: - Fetch
    
    private func fetchAllGoals() {
        fetchAllActiveGoals()
        fetchAllReachedGoals()
    }
    
    
    private func fetchAllActiveGoals() {
        activeGoals = dataManager.fetchGoals(for: .active)
    }
    
    
    private func fetchAllReachedGoals() {
        reachedGoals = dataManager.fetchGoals(for: .reached)
    }
    
    
    //MARK: - Insert
    
    func createGoal(with changeData: Goal.ChangeData) -> Bool {
        guard !GoalErrorHandler.hasErrors(with: changeData) else { return false }
        
        dataManager.insertGoal(with: changeData)
        fetchAllActiveGoals()
        return true
    }
    
    
    //MARK: - Change
    
    func editGoal(_ goal: Goal, with changeData: Goal.ChangeData) -> Bool {
        guard !GoalErrorHandler.hasErrors(with: changeData) else { return false }
        
        dataManager.editGoal(goal, with: changeData)
        fetchAllActiveGoals()
        return true
    }
    
    
    func moveGoals() {
        for goal in activeGoals {
            dataManager.changeGoalOrder(goal, with: goal.sortOrder)
        }
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal) {
        dataManager.deleteGoal(goal)
        fetchAllGoals()
        
        print(activeGoals.map { $0.sortOrder })
    }
}
