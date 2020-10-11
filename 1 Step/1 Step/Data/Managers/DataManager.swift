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
    
    
    //Insert
    
    func insertGoal(with changeData: Goal.ChangeData) {
        let goalsCount = fetchGoalCount()
        
        let newGoal = Goal(context: persistenceManager.context)
        let newStep = Step(context: persistenceManager.context)
        
        newStep.category        = changeData.stepCategory!
        newStep.unit            = changeData.stepUnit!
        newStep.customUnit      = changeData.stepCustomUnit
        newStep.goal            = newGoal

        newGoal.sortOrder       = goalsCount
        newGoal.name            = changeData.name
        newGoal.step            = newStep
        newGoal.stepsNeeded     = changeData.stepsNeeded!
        newGoal.currentSteps    = .zero
        newGoal.currentPercent  = .zero
        newGoal.currentState    = .active
        newGoal.startDate       = Date()
        newGoal.endDate         = nil
        newGoal.mountain        = changeData.mountain!
        newGoal.color           = changeData.color!
        newGoal.milestones      = []
        
        persistenceManager.saveContext()
    }
    
    
    //Fetch
    
    private func fetchGoalCount() -> Int16 {
        let request = Goal.fetchRequest()
        
        do {
            let goals = try persistenceManager.context.fetch(request)
            return Int16(goals.count)
        } catch { return .zero }
    }
}
