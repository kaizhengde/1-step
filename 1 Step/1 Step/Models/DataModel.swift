//
//  DataModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

final class DataModel: ObservableObject {
    
    static let shared = DataModel()
    private let persistenceManager = PersistenceManager.defaults
    private let dataManager = DataManager.defaults
    
    private init() { fetchAllGoals() {} }
    
    
    //MARK: - Data
    
    @Published var activeGoals: [Goal] = []
    @Published var reachedGoals: [Goal] = []
    
    var goals: [Goal] { Array(Set(activeGoals + reachedGoals)) }
    
    
    //MARK: - Fetch
    
    func fetchAllGoals(success: @escaping () -> ()) {
        fetchAllActiveGoals() {
            self.fetchAllReachedGoals() {
                success()
            }
        }
    }
    
    
    private func fetchAllActiveGoals(success: @escaping () -> ()) {
        persistenceManager.context.perform {
            let fetched = self.dataManager.fetchGoals(for: .active)
            self.activeGoals = fetched
            success()
        }
    }
    
    
    private func fetchAllReachedGoals(success: @escaping () -> ()) {
        persistenceManager.context.perform {
            let fetched = self.dataManager.fetchGoals(for: .reached)
            self.reachedGoals = fetched
            success()
        }
    }
    
    
    //MARK: - Insert
    
    func createGoal(with baseData: Goal.BaseData, success: @escaping () -> ()) {
        guard !GoalErrorHandler.hasErrors(with: baseData) else {
            FirebaseAnalyticsEvent.Goal.createFailed()
            return
        }
        
        persistenceManager.context.perform {
            if self.dataManager.insertGoal(with: baseData) {
                self.fetchAllActiveGoals() {
                    success()
                    FirebaseAnalyticsEvent.Goal.goalsCount(self.goals.count)
                    FirebaseAnalyticsEvent.Goal.activeGoalsCount(self.activeGoals.count)
                }
                FirebaseAnalyticsEvent.Goal.insert()
                self.sendGoalChangeFirebaseAnalyticsEvents(with: baseData)
            }
        }
    }
    
    
    //MARK: - Change
    
    func moveGoals(in state: GoalState, success: @escaping () -> ()) {
        let goals = state == .active ? activeGoals : reachedGoals
        
        persistenceManager.context.perform {
            for goal in goals {
                guard self.dataManager.changeGoalOrder(goal, with: goal.sortOrder) else { return }
            }
            self.fetchAllActiveGoals() { success() }
            FirebaseAnalyticsEvent.Goal.moveGoal()
        }
    }
    
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData, success: @escaping () -> ()) {
        guard !GoalErrorHandler.hasErrors(with: baseData),
              !GoalErrorHandler.editGoalHasErrors(with: goal, baseData: baseData)
        else {
            FirebaseAnalyticsEvent.Goal.editFailed()
            return
        }
                
        persistenceManager.context.perform {
            if self.dataManager.editGoal(goal, with: baseData) {
                self.fetchAllActiveGoals() { success() }
                FirebaseAnalyticsEvent.Goal.edit()
                self.sendGoalChangeFirebaseAnalyticsEvents(with: baseData)
            }
        }
    }
    
    
    private func sendGoalChangeFirebaseAnalyticsEvents(with baseData: Goal.BaseData) {
        FirebaseAnalyticsEvent.Goal.nameLength(baseData.name.count)
        FirebaseAnalyticsEvent.Goal.neededStepUnits(baseData.neededStepUnits!)
        FirebaseAnalyticsEvent.Goal.stepCategory(baseData.stepUnit!.category)
        FirebaseAnalyticsEvent.Goal.selectMountain(baseData.mountain!)
        FirebaseAnalyticsEvent.Goal.selectColor(baseData.color!)
        
        if baseData.stepUnit == .custom {
            FirebaseAnalyticsEvent.Goal.customUnit()
            FirebaseAnalyticsEvent.Goal.customUnitLength(baseData.customUnit.count)
        }
    }
    
    
    func addSteps(_ goal: Goal, with newStepUnits: Double, success: @escaping () -> ()) {
        guard !JourneyErrorHandler.addHasErrors(with: goal, newStepUnits: newStepUnits) else { return }
        
        let oldCurrentSteps         = goal.currentSteps
        let oldAmountMilestonesDone = goal.milestones.getAmountDone()
        
        persistenceManager.context.perform {
            if self.dataManager.addSteps(goal, with: newStepUnits) {
                let newCurrentSteps         = goal.currentSteps
                let newAmountMilestonesDone = goal.milestones.getAmountDone()
                
                self.fetchAllGoals() { success() }
                    
                DispatchQueue.global().async {
                    GoalAccomplishmentsHandler.AddSteps.updateStepsAccomplishment(oldCurrentSteps, newCurrentSteps)
                    GoalAccomplishmentsHandler.AddSteps.updateMilestonesAccomplishment(oldAmountMilestonesDone, newAmountMilestonesDone)
                }
                GoalAccomplishmentsHandler.AddSteps.updateGoalsAccomplishment(goal.currentState)
                
                FirebaseAnalyticsEvent.Goal.addSteps()
                if newStepUnits < 0 {
                    FirebaseAnalyticsEvent.Goal.addNegativeSteps()
                }
                
                if goal.currentState == .reached {
                    FirebaseAnalyticsEvent.Goal.reached()
                    FirebaseAnalyticsEvent.Goal.reachedGoalsCount(self.reachedGoals.count)
                }
            }
        }
    }
    
    
    func updateReachedGoalsPercentage() {
        persistenceManager.context.perform {
            _ = self.dataManager.updateReachedGoalsPercentage()
        }
    }
    
    
    //Goal Notification
    
    func addGoalNotification(_ goal: Goal, with notificationData: Goal.NotificationData, success: @escaping () -> ()) {
        persistenceManager.context.perform {
            if self.dataManager.addGoalNotification(goal, with: notificationData) {
                success()
                FirebaseAnalyticsEvent.Goal.addTimeReminder()
                FirebaseAnalyticsEvent.Goal.timeRemindersCount(goal.notifications.count)
            }
        }
    }
    
    
    func editGoalNotification(_ notification: GoalNotification, with notificationData: Goal.NotificationData, success: @escaping () -> ()) {
        persistenceManager.context.perform {
            if self.dataManager.editGoalNotification(notification, with: notificationData) { success() }
        }
    }
    
    
    func removeGoalNotification(_ notification: GoalNotification, of goal: Goal, success: @escaping () -> ()) {
        persistenceManager.context.perform {
            if self.dataManager.removeGoalNotification(notification, of: goal) { success() }
        }
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal, success: @escaping () -> ()) {
        persistenceManager.context.perform {
            if self.dataManager.deleteGoal(goal) { self.fetchAllGoals() { success() } }
            FirebaseAnalyticsEvent.Goal.delete()
        }
    }
    
    
    func deleteAllGoals(success: @escaping () -> ()) {
        let goalsCount = goals.count
        persistenceManager.context.perform {
            if self.dataManager.deleteAllGoals() {
                self.fetchAllGoals() {
                    GoalAccomplishmentsHandler.resetAllAccomplishments()
                    success()
                }
                for _ in 0..<goalsCount {
                    FirebaseAnalyticsEvent.Goal.delete()
                }
            }
        }
    }
}
