//
//  GoalBaseDataHandlerTests.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 05.12.20.
//

@testable import __Step
import XCTest
import Foundation

class GoalBaseDataHandlerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        GoalTestsModel.deleteAllGoals()
        super.tearDown()
    }
    
    //MARK: - setupCalculationBaseData(with goal: Goal, _ step: Step)
    
    //NeededSteps Invariants
    
    func test_neededSteps_greaterThanOrEqual_neededStepUnits() {
        GoalTestsModel.generateRandomGoals(amount: 100)
        
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            let neededStepUnits = goal.neededStepUnits
            
            XCTAssertGreaterThanOrEqual(neededSteps, neededStepUnits)
        }
    }
    
    
    func test_neededSteps_greaterThanOrEqual_10() {
        GoalTestsModel.generateRandomGoals(amount: 100)
        
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            
            XCTAssertGreaterThanOrEqual(neededSteps, 10)
        }
    }
    
    
    func test_neededSteps_lessThanOrEqual_1000() {
        GoalTestsModel.generateRandomGoals(amount: 100)
        
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            
            XCTAssertLessThanOrEqual(neededSteps, 1000)
        }
    }
    
    
    //StepRatio + AddSteps
    
    func one_can_always_add_lessThanOrEqual_one_single_step() {
        for goal in DataModel.shared.activeGoals {
            var arrayWithLeastStepUnit: [Double] = []
            var leastStepUnitAdd: Double = 0
            
            if goal.step.unit.isDual {
                arrayWithLeastStepUnit = goal.step.addArrayDual.map { Double($0)! }
                arrayWithLeastStepUnit = arrayWithLeastStepUnit.map { $0/goal.step.unit.dualRatio }
            } else {
                arrayWithLeastStepUnit = goal.step.addArray.map { Double($0)! }
            }
            
            arrayWithLeastStepUnit = arrayWithLeastStepUnit.filter {$0 > 0}
            leastStepUnitAdd = arrayWithLeastStepUnit.reduce(arrayWithLeastStepUnit[0], { min($0, $1) })
            
            let leastStepAdd = leastStepUnitAdd*Double(goal.step.unitRatio)
            
            XCTAssertLessThanOrEqual(leastStepAdd, 1)
        }
    }
    
    
    func test_one_can_always_add_lessThanOrEqual_one_single_step__SIMPLE() {
        GoalTestsModel.generateRandomGoals(amount: 100)
        one_can_always_add_lessThanOrEqual_one_single_step()
    }
    
    
    func test_one_can_always_add_lessThanOrEqual_one_single_step__HARD() {
        GoalTestsModel.generateRandomDualGoals(amount: 100)
        one_can_always_add_lessThanOrEqual_one_single_step()
    }
    
    
    //MARK: - generateMilestones(with goal: Goal) -> Set<Milestone>
    
    func test_generateMilestones() {
        
        
    }
}

