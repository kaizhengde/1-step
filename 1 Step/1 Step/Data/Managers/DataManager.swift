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
        
        newStep.unit                = baseData.stepUnit!
        newStep.customUnit          = baseData.customUnit
        newStep.goal                = newGoal
    
        newGoal.name                = baseData.name
        newGoal.step                = newStep
        newGoal.neededStepUnits     = baseData.neededStepUnits!
        newGoal.currentStepUnits    = .zero
        newGoal.currentSteps        = .zero
        newGoal.currentPercent      = Int16(Int.random(in: 0...100))
        newGoal.currentState        = .active
        newGoal.startDate           = Date()
        newGoal.endDate             = nil
        newGoal.mountain            = baseData.mountain!
        newGoal.color               = baseData.color!
            
        //Calculate
            
        newGoal.sortOrder           = fetchActiveGoalCount()
        newStep.unitRatio           = JourneyDataHandler.calculateRatio(from: baseData)
        newGoal.neededSteps         = baseData.neededStepUnits! * newStep.unitRatio
        let addArrays               = JourneyDataHandler.calculateStepAddArrays(from: baseData)
        newStep.addArray            = addArrays.unit
        newStep.addArrayDual        = addArrays.dual
        newGoal.milestones          = JourneyDataHandler.generateMilestones(with: newGoal)
        
        return persistenceManager.saveContext()
    }
    
    
    //MARK: - Change
    
    func changeGoalOrder(_ goal: Goal, with newOrder: Int16) -> Bool {
        goal.sortOrder      = newOrder
        return persistenceManager.saveContext()
    }
    
    
    func editGoal(_ goal: Goal, with baseData: Goal.BaseData) -> Bool {
        
        goal.name               = baseData.name
        goal.step.unit          = baseData.stepUnit!
        goal.step.customUnit    = baseData.customUnit
        goal.neededStepUnits    = baseData.neededStepUnits!
        goal.mountain           = baseData.mountain!
        goal.color              = baseData.color!
        
        //Calculate
        
        goal.step.unitRatio     = JourneyDataHandler.calculateRatio(from: baseData)
        goal.neededSteps        = baseData.neededStepUnits! * goal.step.unitRatio
        let addArrays           = JourneyDataHandler.calculateStepAddArrays(from: baseData)
        goal.step.addArray      = addArrays.unit
        goal.step.addArrayDual  = addArrays.dual
        goal.milestones         = JourneyDataHandler.generateMilestones(with: goal)
        
        return persistenceManager.saveContext()
    }
    
    
    func addSteps(_ goal: Goal, stepUnits: Double, stepUnitsDual: Double) -> Bool {
        
        let journeyData = JourneyDataHandler.addStepsAndUpdate(with: goal, stepUnits, stepUnitsDual)
        
        goal.currentStepUnits   = journeyData.currentStepUnits
        goal.currentSteps       = journeyData.currentSteps
        goal.currentPercent     = journeyData.currentPercent
        goal.currentState       = journeyData.currentState
        goal.milestones         = journeyData.milestones
        
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
