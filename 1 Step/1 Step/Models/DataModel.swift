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
        guard dataManager.insertGoal(with: changeData) else { return false }
        
        fetchAllActiveGoals()
        return true
    }
    
    
    //MARK: - Change
    
    func editGoal(_ goal: Goal, with changeData: Goal.ChangeData) -> Bool {
        guard !GoalErrorHandler.hasErrors(with: changeData) else { return false }
        guard dataManager.editGoal(goal, with: changeData) else { return false }
        
        fetchAllActiveGoals()
        return true
    }
    
    
    func moveGoals() -> Bool {
        for goal in activeGoals {
            guard dataManager.changeGoalOrder(goal, with: goal.sortOrder) else { return false }
        }
        
        fetchAllActiveGoals()
        return true
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal) -> Bool {
        guard dataManager.deleteGoal(goal) else { return false }
        
        fetchAllGoals()
        print(activeGoals.map { $0.sortOrder })
        return true
    }
}
