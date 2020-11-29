//
//  CoreDataManager.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI
import CoreData

final class DataManager {
    
    static let defaults = DataManager()
    private init() {}
    
    private let persistenceManager = PersistenceManager.defaults
    
    
    //MARK: - Fetch
    
    private func fetchGoalCount(for state: GoalState) -> Int16 {
        let request = Goal.fetchRequest()
        request.predicate = NSPredicate(format: "currentState == \(state.rawValue)")
        
        do {
            let goals = try persistenceManager.context.fetch(request)
            return Int16(goals.count)
        } catch { return .zero }
    }
    
    
    func fetchGoals(for state: GoalState) -> [Goal] {
        let request = Goal.fetchRequest()
        request.predicate = NSPredicate(format: "currentState == \(state.rawValue)")
        request.sortDescriptors = [NSSortDescriptor(key: "sortOrder", ascending: true)]
        
        do {
            let goals = try persistenceManager.context.fetch(request)
            return goals as! [Goal]
        } catch { return [] }
    }
    
    
    //MARK: - Insert
    
    func insertGoal(with baseData: Goal.BaseData) -> Bool {
        
        let newGoal = Goal(context: persistenceManager.context)
        let newStep = Step(context: persistenceManager.context)
        
        newStep.unit                = baseData.stepUnit!
        newStep.customUnit          = baseData.customUnit
        newStep.goal                = newGoal
    
        newGoal.name                = baseData.name
        newGoal.step                = newStep
        newGoal.neededStepUnits     = baseData.neededStepUnits!
        newGoal.currentStepUnits    = .zero
        newGoal.currentSteps        = .zero
        newGoal.currentPercent      = .zero
        newGoal.currentState        = .active
        newGoal.startDate           = Date()
        newGoal.endDate             = nil
        newGoal.mountain            = baseData.mountain!
        newGoal.color               = baseData.color!
            
        //Calculate
            
        newGoal.sortOrder           = fetchGoalCount(for: .active)
        newStep.unitRatio           = JourneyDataHandler.calculateRatio(from: baseData)
        newGoal.neededSteps         = baseData.neededStepUnits! * newStep.unitRatio
        newGoal.stepsDate           = Array<Date>(repeating: .distantFuture, count: Int(newGoal.neededSteps))
        let addArrays               = JourneyDataHandler.calculateStepAddArrays(from: baseData)
        newStep.addArray            = addArrays.unit
        newStep.addArrayDual        = addArrays.dual
        newGoal.milestones          = JourneyDataHandler.generateMilestones(with: newGoal)
        newGoal.notifications       = []
        
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Change
    
    //Goal Edit
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData) -> Bool {
        
        let oldUnit             = goal.step.unit
        
        goal.name               = baseData.name
        goal.step.unit          = baseData.stepUnit!
        goal.step.customUnit    = baseData.customUnit
        goal.neededStepUnits    = baseData.neededStepUnits!
        goal.mountain           = baseData.mountain!
        goal.color              = baseData.color!
        
        //Calculate
        
        let oldDoneMilestonesAmount = goal.milestones.reduce(0) { $0 + ($1.state == .done ? 1 : 0) }
        
        goal.step.unitRatio     = JourneyDataHandler.calculateRatio(from: baseData)
        goal.neededSteps        = baseData.neededStepUnits! * goal.step.unitRatio
        goal.stepsDate          = JourneyDataHandler.updateStepsDate(with: goal)
        let addArrays           = JourneyDataHandler.calculateStepAddArrays(from: baseData)
        goal.step.addArray      = addArrays.unit
        goal.step.addArrayDual  = addArrays.dual
        goal.milestones         = JourneyDataHandler.generateMilestones(with: goal)
        
        guard updateSteps(goal, oldUnit) else { return false }
        
        let newDoneMilestonesAmount = goal.milestones.reduce(0) { $0 + ($1.state == .done ? 1 : 0) }
        JourneyDataHandler.updateMilestonesAccomplishment(oldDoneMilestonesAmount, newDoneMilestonesAmount)
        
        for notification in goal.notifications {
            GoalNotificationManager.removeNotifications(with: notification.id, of: goal)
            let notificationData: Goal.NotificationData = (notification.id, notification.time, notification.weekdays)
            GoalNotificationManager.sceduleNotifications(with: notificationData, of: goal) { _ in }
        }
        
        return persistenceManager.saveContext()
    }
    

    private func updateSteps(_ goal: Goal, _ oldUnit: StepUnit) -> Bool {
        goal.currentStepUnits *= oldUnit.translateMultiplier(to: goal.step.unit)
        return addSteps(goal, with: 0)
    }
    
    
    //Goal Add Steps
    
    func addSteps(_ goal: Goal, with newStepUnits: Double) -> Bool {
        
        let journeyData = JourneyDataHandler.addStepsAndUpdate(with: goal, newStepUnits: newStepUnits)
        
        goal.currentStepUnits   = journeyData.currentStepUnits
        goal.currentSteps       = journeyData.currentSteps
        goal.currentPercent     = journeyData.currentPercent
        goal.currentState       = journeyData.currentState
        goal.stepsDate          = journeyData.stepsDate
        goal.milestones         = journeyData.milestones
        
        var updateResult = true
        
        if goal.currentState == .reached {
            updateResult = updateGoalsSortOrder(with: goal, state: .active)
            goal.sortOrder = fetchGoalCount(for: .reached)-1
            for notification in goal.notifications {
                GoalNotificationManager.removeNotifications(with: notification.id, of: goal)
            }
            goal.notifications = []
        }
        
        return updateResult && persistenceManager.saveContext()
    }
    
    
    //Goal sort order
    
    func changeGoalOrder(_ goal: Goal, with newOrder: Int16) -> Bool {
        goal.sortOrder      = newOrder
        return persistenceManager.saveContext()
    }
    
    
    private func updateGoalsSortOrder(with goal: Goal, state: GoalState) -> Bool {
        let goals = state == .active ? DataModel.shared.activeGoals : DataModel.shared.reachedGoals
        for g in goals {
            if g.sortOrder > goal.sortOrder {
                guard changeGoalOrder(g, with: g.sortOrder-1) else { return false }
            }
        }
        return true
    }
    
    
    //Goal Percentage
    
    func updateReachedGoalsPercentage() -> Bool {
        for goal in DataModel.shared.reachedGoals {
            goal.currentPercent = Int16(Int.random(in: 20...80))
        }
        
        return persistenceManager.saveContext()
    }
    
    
    //Goal Notification
    
    func addGoalNotification(_ goal: Goal, with notificationData: Goal.NotificationData) -> Bool {
        
        let newNotification = GoalNotification(context: persistenceManager.context)
        
        newNotification.id          = notificationData.id
        newNotification.sortOrder   = Int16(goal.notifications.count)
        newNotification.time        = notificationData.time
        newNotification.weekdays    = notificationData.weekdays
        newNotification.parentGoal  = goal
        
        goal.notifications.insert(newNotification)
                        
        return persistenceManager.saveContext()
    }
    
    
    func editGoalNotification(_ notification: GoalNotification, with notificationData: Goal.NotificationData) -> Bool {
        notification.time           = notificationData.time
        notification.weekdays       = notificationData.weekdays
        
        return persistenceManager.saveContext()
    }
    
    
    func removeGoalNotification(_ notification: GoalNotification, of goal: Goal) -> Bool {
        for n in goal.notifications {
            if n.sortOrder > notification.sortOrder {
                guard changeNotificationOrder(n, with: n.sortOrder-1) else { return false }
            }
        }
        
        goal.notifications.remove(notification)
        persistenceManager.context.delete(notification)
                
        return persistenceManager.saveContext()
    }
    
    
    func changeNotificationOrder(_ notification: GoalNotification, with newOrder: Int16) -> Bool {
        notification.sortOrder = newOrder
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal) -> Bool {
        var updateResult = true
        updateResult = updateGoalsSortOrder(with: goal, state: goal.currentState)
        
        GoalDeleteHandler.updateAccomplishments(with: goal)
        
        for notification in goal.notifications {
            GoalNotificationManager.removeNotifications(with: notification.id, of: goal)
        }
        persistenceManager.context.delete(goal)
        return updateResult && persistenceManager.saveContext()
    }
}
