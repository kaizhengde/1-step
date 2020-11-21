//
//  GoalTestsModel.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

@testable import __Step

enum GoalTestsModel {
    
    
    //MARK: - Generate Random Goals
    
    static func generateRandomRepsGoals(amount: Int) {
        for _ in 0..<amount {
            let baseData: Goal.BaseData = (
                name:               TestsHelper.randomString(length: Int.random(in: 1...Goal.nameDigitsLimit)),
                stepUnit:           StepUnit(rawValue: Int16.random(in: 6...11)),
                customUnit: "",
                neededStepUnits:    Int16.random(in: 10...1000),
                mountain:           MountainImage(rawValue: Int16.random(in: 0...2)),
                color:              UserColor(rawValue: Int16.random(in: 0...2))
            )
            
            _ = DataModel.shared.createGoal(with: baseData)
        }
    }
    
    
    
}
