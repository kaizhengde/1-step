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
    
    private init() { fetchAllGoals() {} }
    
    
    //MARK: - Data
    
    @Published var activeGoals: [Goal] = []
    @Published var reachedGoals: [Goal] = []
    
    
    //MARK: - Fetch
    
    private func fetchAllGoals(completion: @escaping () -> ()) {
        fetchAllActiveGoals() {
            self.fetchAllReachedGoals() {
                completion()
            }
        }
    }
    
    
    private func fetchAllActiveGoals(completion: @escaping () -> ()) {
        DispatchQueue.global().async {
            let fetched = self.dataManager.fetchGoals(for: .active)
            DispatchQueue.main.async {
                self.activeGoals = fetched
                completion()
            }
        }
    }
    
    
    private func fetchAllReachedGoals(completion: @escaping () -> ()) {
        DispatchQueue.global().async {
            let fetched = self.dataManager.fetchGoals(for: .reached)
            DispatchQueue.main.async {
                self.reachedGoals = fetched
                completion()
            }
        }
    }
    
    
    //MARK: - Insert
    
    func createGoal(with baseData: Goal.BaseData, completion: @escaping (Bool) -> ()) {
        guard !GoalErrorHandler.hasErrors(with: baseData) else {
            completion(false)
            return
        }
        
        if dataManager.insertGoal(with: baseData) {
            fetchAllActiveGoals() {
                completion(true)
            }
        } else { completion(false) }
    }
    
    
    //MARK: - Change
    
    func moveGoals(in state: GoalState, completion: @escaping (Bool) -> ()) {
        let goals = state == .active ? activeGoals : reachedGoals
        
        DispatchQueue.global().async {
            for goal in goals {
                guard self.dataManager.changeGoalOrder(goal, with: goal.sortOrder) else {
                    DispatchQueue.main.async { completion(false) }
                    return
                }
            }
            self.fetchAllActiveGoals() {
                DispatchQueue.main.async { completion(true) }
            }
        }
    }
    
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData, completion: @escaping (Bool) -> ()) {
        guard !GoalErrorHandler.hasErrors(with: baseData),
              !GoalErrorHandler.editGoalHasErrors(with: goal, baseData: baseData) else {
            completion(false)
            return
        }
        
        DispatchQueue.global().async {
            if self.dataManager.editGoal(goal, with: baseData) {
                self.fetchAllActiveGoals() {
                    DispatchQueue.main.async { completion(true) }
                }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
    
    
    func addSteps(_ goal: Goal, with newStepUnits: Double, completion: @escaping ((Bool) -> Void)) {
        guard !JourneyErrorHandler.addHasErrors(with: goal, newStepUnits: newStepUnits) else {
            completion(false)
            return
        }
        
        DispatchQueue.global().async {
            if self.dataManager.addSteps(goal, with: newStepUnits) {
                self.fetchAllGoals() {
                    DispatchQueue.main.async { completion(true) }
                }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
    
    
    func updateReachedGoalsPercentage() {
        DispatchQueue.global().async { _ = self.dataManager.updateReachedGoalsPercentage() }
    }
    
    
    //Goal Notification
    
    func addGoalNotification(_ goal: Goal, with notificationData: Goal.NotificationData, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            if self.dataManager.addGoalNotification(goal, with: notificationData) {
                DispatchQueue.main.async { completion(true) }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
    
    
    func editGoalNotification(_ notification: GoalNotification, with notificationData: Goal.NotificationData, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            if self.dataManager.editGoalNotification(notification, with: notificationData) {
                DispatchQueue.main.async { completion(true) }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
    
    
    func removeGoalNotification(_ notification: GoalNotification, of goal: Goal, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            if self.dataManager.removeGoalNotification(notification, of: goal) {
                DispatchQueue.main.async { completion(true) }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            if self.dataManager.deleteGoal(goal) {
                self.fetchAllGoals() {
                    DispatchQueue.main.async { completion(true) }
                }
            } else { DispatchQueue.main.async { completion(false) } }
        }
    }
}
