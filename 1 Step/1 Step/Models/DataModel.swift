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
        let fetched = dataManager.fetchGoals(for: .active)
        activeGoals = fetched
        completion()
    }
    
    
    private func fetchAllReachedGoals(completion: @escaping () -> ()) {
        let fetched = dataManager.fetchGoals(for: .reached)
        reachedGoals = fetched
        completion()
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
        
        for goal in goals {
            guard self.dataManager.changeGoalOrder(goal, with: goal.sortOrder) else {
                completion(false) 
                return
            }
        }
        self.fetchAllActiveGoals() { completion(true) }
    }
    
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData, completion: @escaping (Bool) -> ()) {
        guard !GoalErrorHandler.hasErrors(with: baseData),
              !GoalErrorHandler.editGoalHasErrors(with: goal, baseData: baseData) else {
            completion(false)
            return
        }
        
        let oldAmountMilestonesDone = goal.milestones.getAmountDone()
        
        dataManager.editGoal(goal, with: baseData) { success in
            if success {
                let newAmountMilestonesDone = goal.milestones.getAmountDone()
                
                GoalAccomplishmentsHandler.AddSteps.updateMilestonesAccomplishment(oldAmountMilestonesDone, newAmountMilestonesDone)
                
                self.fetchAllActiveGoals() { completion(true) }
                
            } else { completion(false) }
        }
    }
    
    
    func addSteps(_ goal: Goal, with newStepUnits: Double, completion: @escaping ((Bool) -> Void)) {
        guard !JourneyErrorHandler.addHasErrors(with: goal, newStepUnits: newStepUnits) else {
            completion(false)
            return
        }
        
        let oldCurrentSteps         = goal.currentSteps
        let oldAmountMilestonesDone = goal.milestones.getAmountDone()
        
        dataManager.addSteps(goal, with: newStepUnits) { success in
            if success {
                let newCurrentSteps         = goal.currentSteps
                let newAmountMilestonesDone = goal.milestones.getAmountDone()
                
                GoalAccomplishmentsHandler.AddSteps.updateStepsAccomplishment(oldCurrentSteps, newCurrentSteps)
                GoalAccomplishmentsHandler.AddSteps.updateMilestonesAccomplishment(oldAmountMilestonesDone, newAmountMilestonesDone)
                GoalAccomplishmentsHandler.AddSteps.updateGoalsAccomplishment(goal.currentState)
                
                self.fetchAllGoals() { completion(true) }
                
            } else { completion(false) }
        }
    }
    
    
    func updateReachedGoalsPercentage() {
        _ = dataManager.updateReachedGoalsPercentage()
    }
    
    
    //Goal Notification
    
    func addGoalNotification(_ goal: Goal, with notificationData: Goal.NotificationData, completion: @escaping (Bool) -> ()) {
        if dataManager.addGoalNotification(goal, with: notificationData) { completion(true) }
        else { completion(false) }
    }
    
    
    func editGoalNotification(_ notification: GoalNotification, with notificationData: Goal.NotificationData, completion: @escaping (Bool) -> ()) {
        if dataManager.editGoalNotification(notification, with: notificationData) { completion(true) }
        else { completion(false) }
    }
    
    
    func removeGoalNotification(_ notification: GoalNotification, of goal: Goal, completion: @escaping (Bool) -> ()) {
        if dataManager.removeGoalNotification(notification, of: goal) { completion(true) }
        else { completion(false) }
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal, completion: @escaping (Bool) -> ()) {
        if dataManager.deleteGoal(goal) { fetchAllGoals() { completion(true) } }
        else { completion(false) }
    }
}
