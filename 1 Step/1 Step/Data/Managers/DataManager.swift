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
    
    private var persistenceManager = PersistenceManager.defaults
    
    
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
    
        newGoal.sortOrder           = fetchGoalCount(for: .active)
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
        newGoal.notifications       = []
        newGoal.addEntries          = []
            
        GoalBaseDataHandler.setupCalculationBaseData(with: newGoal, newStep)
        
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Change
    
    //Goal Edit
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData) -> Bool {
        
        let oldUnit                 = goal.step.unit
            
        goal.name                   = baseData.name
        goal.step.unit              = baseData.stepUnit!
        goal.step.customUnit        = baseData.customUnit
        goal.neededStepUnits        = baseData.neededStepUnits!
        goal.mountain               = baseData.mountain!
        goal.color                  = baseData.color!
        
        GoalBaseDataHandler.setupCalculationBaseData(with: goal, goal.step)
        
        //Update Currents
        
        goal.currentStepUnits      *= oldUnit.translateMultiplier(to: goal.step.unit)
        guard addSteps(goal, with: 0) else { return false }
        
        GoalNotificationsHandler.updateAfterGoalEdit(with: goal)
        
        return persistenceManager.saveContext()
    }
    
    
    //Goal Add Steps
    
    func addSteps(_ goal: Goal, with newStepUnits: Double) -> Bool {
        GoalJourneyDataHandler.addStepsAndUpdateData(with: goal, newStepUnits: newStepUnits)
        
        //Goal Reached
        if goal.currentState == .reached {
            _ = updateGoalsSortOrder(with: goal, state: .active)
            goal.sortOrder      = fetchGoalCount(for: .reached)

            GoalNotificationsHandler.deleteAllNotifications(with: goal)
            goal.notifications  = []
        }
        
        return persistenceManager.saveContext()
    }
    
    
    //Goal sort order
    
    func changeGoalOrder(_ goal: Goal, with newOrder: Int16) -> Bool {
        goal.sortOrder = newOrder
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
    
    
    //GoalReached Percentage
    
    func updateReachedGoalsPercentage() -> Bool {
        for goal in DataModel.shared.reachedGoals {
            goal.currentPercent = Int16(Int.random(in: 20...80))
        }
        
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal) -> Bool {
        guard updateGoalsSortOrder(with: goal, state: goal.currentState) else { return false }
        
        GoalAccomplishmentsHandler.Delete.updateAccomplishments(with: goal)
        GoalNotificationsHandler.deleteAllNotifications(with: goal)
        
        persistenceManager.context.delete(goal)
        return persistenceManager.saveContext()
    }
    
    
    func deleteAllGoals() -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistenceManager.container.persistentStoreCoordinator.execute(deleteRequest, with: persistenceManager.context)
            return true
            
        } catch let error as NSError {
            PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral) {
                OneSTextPopupView(titleText: Localized.error, bodyText: error.localizedDescription)
            }
        }
        
        return false
    }
}


//MARK: - GoalNotification

extension DataManager {
    
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
    
}
