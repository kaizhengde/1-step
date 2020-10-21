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
    
    private func fetchActiveGoalCount() -> Int16 {
        let request = Goal.fetchRequest()
        request.predicate = NSPredicate(format: "currentState == 0")
        
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
    
    func insertGoal(with changeData: Goal.ChangeData) -> Bool {
        let activeGoalsCount = fetchActiveGoalCount()
        
        let newGoal = Goal(context: persistenceManager.context)
        let newStep = Step(context: persistenceManager.context)
        
        newStep.category        = changeData.stepCategory!
        newStep.unit            = changeData.stepUnit!
        newStep.customUnit      = changeData.stepCustomUnit
        newStep.goal            = newGoal

        newGoal.sortOrder       = activeGoalsCount
        newGoal.name            = changeData.name
        newGoal.step            = newStep
        newGoal.stepsNeeded     = changeData.stepsNeeded!
        newGoal.currentSteps    = .zero
        newGoal.currentPercent  = Int16(Int.random(in: 0...100))
        newGoal.currentState    = .active
        newGoal.startDate       = Date()
        newGoal.endDate         = nil
        newGoal.mountain        = changeData.mountain!
        newGoal.color           = changeData.color!
        newGoal.milestones      = getNewMilestones(with: newGoal)
        
        return persistenceManager.saveContext()
    }
    
    
    private func getNewMilestones(with goal: Goal) -> Set<Milestone> {
        MilestonesHandler.generateNewMilestones(with: goal)
        
        return []
    }
    
    
    //MARK: - Change
    
    func editGoal(_ goal: Goal, with changeData: Goal.ChangeData) -> Bool {
        goal.name            = changeData.name
        goal.step.category   = changeData.stepCategory!
        goal.step.unit       = changeData.stepUnit!
        goal.step.customUnit = changeData.stepCustomUnit
        goal.stepsNeeded     = changeData.stepsNeeded!
        goal.mountain        = changeData.mountain!
        goal.color           = changeData.color!
        
        return persistenceManager.saveContext()
    }
    
    
    func changeGoalOrder(_ goal: Goal, with newOrder: Int16) -> Bool {
        goal.sortOrder      = newOrder
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Delete
    
    func deleteGoal(_ goal: Goal) -> Bool {
        if goal.currentState == .active {
            for activeGoal in DataModel.shared.activeGoals {
                if activeGoal.sortOrder > goal.sortOrder {
                    guard changeGoalOrder(activeGoal, with: activeGoal.sortOrder-1) else { return false }
                }
            }
        }
        
        persistenceManager.context.delete(goal)
        return persistenceManager.saveContext()
    }
}
