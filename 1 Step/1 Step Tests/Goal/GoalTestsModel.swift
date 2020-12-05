//
//  GoalTestsModel.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

@testable import __Step

enum GoalTestsModel {
    
    
    //MARK: - Generate Random Goals
    
    static func generateRandomGoals(amount: Int) {
        for _ in 0..<amount {
            let stepUnit = StepUnit(rawValue: Int16.random(in: 0...11))
            let neededStepUnits = Int16.random(in: (stepUnit!.isDual ? 1 : 10)...1000)
            
            let baseData: Goal.BaseData = (
                name:               "Test",
                stepUnit:           stepUnit,
                customUnit:         "",
                neededStepUnits:    neededStepUnits,
                mountain:           .mountain0,
                color:              .user0
            )
            
            DataModel.shared.createGoal(with: baseData) { print($0) }
        }
    }
    
    
    static func generateRandomRepsGoals(amount: Int) {
        for _ in 0..<amount {
            let baseData: Goal.BaseData = (
                name:               "Test",
                stepUnit:           StepUnit(rawValue: Int16.random(in: 6...11)), //Only Rep StepUnits
                customUnit:         "",
                neededStepUnits:    Int16.random(in: 10...1000),
                mountain:           .mountain0,
                color:              .user0
            )
            
            DataModel.shared.createGoal(with: baseData) { print($0) }
        }
    }
    
    
    static func generateRandomDualGoals(amount: Int) {
        for _ in 0..<amount {
            var stepUnit: StepUnit = .none
            repeat {
                stepUnit = StepUnit(rawValue: Int16.random(in: 0...5))!
            } while !stepUnit.isDual
    
            
            let baseData: Goal.BaseData = (
                name:               "Test",
                stepUnit:           stepUnit,
                customUnit:         "",
                neededStepUnits:    Int16.random(in: 1...1000),
                mountain:           .mountain0,
                color:              .user0
            )
            
            DataModel.shared.createGoal(with: baseData) { print($0) }
        }
    }
    
    
    //MARK: - Delete
    
    static func deleteAllGoals() {
        _ = DataModel.shared.deleteAllGoals()
    }
}
