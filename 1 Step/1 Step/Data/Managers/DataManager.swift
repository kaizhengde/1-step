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
    
    func insertGoal(with baseData: Goal.BaseData) -> Bool {
        
        let newGoal = Goal(context: persistenceManager.context)
        let newStep = Step(context: persistenceManager.context)
        
        newStep.unit            = baseData.stepUnit!
        newStep.customUnit      = baseData.customUnit
        newStep.goal            = newGoal

        newGoal.name            = baseData.name
        newGoal.step            = newStep
        newGoal.neededStepUnits = baseData.neededStepUnits!
        newGoal.currentSteps    = .zero
        newGoal.currentPercent  = Int16(Int.random(in: 0...100)) //For now
        newGoal.currentState    = .active
        newGoal.startDate       = Date()
        newGoal.endDate         = nil
        newGoal.mountain        = baseData.mountain!
        newGoal.color           = baseData.color!
        
        //Calculate
        
        let activeGoalsCount    = fetchActiveGoalCount()
        
        let stepUnitRatio       = JourneyDataHandler.calculateRatio(from: baseData)
        let goalNeededSteps     = baseData.neededStepUnits! * stepUnitRatio
        let stepsAddArray          = JourneyDataHandler.calculateStepsAddArray(from: baseData)
        let milestones          = JourneyDataHandler.generateMilestones(with: newGoal)
        
        newGoal.sortOrder       = activeGoalsCount
        newStep.unitRatio       = stepUnitRatio
        newGoal.neededSteps     = goalNeededSteps
        newGoal.stepsAddArray      = stepsAddArray
        newGoal.milestones      = milestones
        
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Change
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData) -> Bool {
        
        goal.name            = baseData.name
        goal.step.unit       = baseData.stepUnit!
        goal.step.customUnit = baseData.customUnit
        goal.neededStepUnits = baseData.neededStepUnits!
        goal.mountain        = baseData.mountain!
        goal.color           = baseData.color!
        
        //Calculate
        
        let stepUnitRatio    = JourneyDataHandler.calculateRatio(from: baseData)
        let goalNeededSteps  = baseData.neededStepUnits! * stepUnitRatio
        let stepsAddArray    = JourneyDataHandler.calculateStepsAddArray(from: baseData)
        let milestones       = JourneyDataHandler.generateMilestones(with: goal)
        
        goal.step.unitRatio  = stepUnitRatio
        goal.neededSteps     = goalNeededSteps
        goal.stepsAddArray   = stepsAddArray
        goal.milestones      = milestones
        
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
