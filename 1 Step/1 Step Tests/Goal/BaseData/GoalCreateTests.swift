//
//  GoalCreateTests.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 05.12.20.
//

@testable import __Step
import XCTest

final class GoalCreateTests: XCTestCase {
    
    override func invokeTest() {
        let expectationGeneral  = XCTestExpectation(description: "TestGeneral")
        let expectationHard     = XCTestExpectation(description: "TestHard")
        let expectationBig      = XCTestExpectation(description: "TestBig")
        
        //General
        GoalTestsModel.generateRandomGoals(amount: 100) {
            expectationGeneral.fulfill()
        }
        wait(for: [expectationGeneral], timeout: 60.0)
        XCTAssertEqual(DataModel.shared.activeGoals.count, 100)
        super.invokeTest()
        
        
        //Only Dual Goals (Hard)
        GoalTestsModel.generateRandomDualGoals(amount: 100) {
            expectationHard.fulfill()
        }
        wait(for: [expectationHard], timeout: 60.0)
        XCTAssertEqual(DataModel.shared.activeGoals.count, 100)
        super.invokeTest()
        
        
        //Big
        GoalTestsModel.generateRandomGoals(amount: 500) {
            expectationBig.fulfill()
        }
        wait(for: [expectationBig], timeout: 60.0)
        XCTAssertEqual(DataModel.shared.activeGoals.count, 500)
        super.invokeTest()
    }
    
    
    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        let expectationDelete  = XCTestExpectation(description: "Delete")
        GoalTestsModel.deleteAllGoals { expectationDelete.fulfill() }
        wait(for: [expectationDelete], timeout: 60.0)
        super.tearDown()
    }
    
    
    //MARK: - setupCalculationBaseData(with goal: Goal, _ step: Step)
    
    //Basics
    
    func test_no_notifications() {
        for goal in DataModel.shared.activeGoals {
            XCTAssertEqual(goal.notifications, [])
        }
    }
    
    
    func test_no_addEntries() {
        for goal in DataModel.shared.activeGoals {
            XCTAssertEqual(goal.addEntries, [])
        }
    }
    
    
    func test_milestones_not_empty() {
        for goal in DataModel.shared.activeGoals {
            XCTAssertGreaterThan(goal.milestones.count, 0)
        }
    }
    
    
    //NeededSteps Invariants
    
    func test_neededSteps_greaterThanOrEqual_neededStepUnits() {
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            let neededStepUnits = goal.neededStepUnits
            
            XCTAssertGreaterThanOrEqual(neededSteps, neededStepUnits)
        }
    }
    
    
    func test_neededSteps_greaterThanOrEqual_10() {
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            
            XCTAssertGreaterThanOrEqual(neededSteps, 10)
        }
    }
    
    
    func test_neededSteps_lessThanOrEqual_1000() {
        for goal in DataModel.shared.activeGoals {
            let neededSteps = goal.neededSteps
            
            XCTAssertLessThanOrEqual(neededSteps, 1000)
        }
    }
    
    
    //StepRatio + AddSteps
    
    func test_one_can_always_add_lessThanOrEqual_one_single_step() {
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
    
    
    //Sort Order
    
    func test_initial_sortOrder() {
        for i in 0..<DataModel.shared.activeGoals.count {
            let sortOrder = DataModel.shared.activeGoals[i].sortOrder
            
            XCTAssertEqual(sortOrder, Int16(i+1))
        }
    }
    
    
    //MARK: - generateMilestones(with goal: Goal) -> Set<Milestone>
    
    
    //Milestone State
    
    func test_first_milestone_is_current() {
        for goal in DataModel.shared.activeGoals {
            let firstMilestone = goal.sortedMilestones.first!
            
            XCTAssertEqual(firstMilestone.state, .current)
        }
    }
    
    
    func test_all_milestones_are_active_except_first() {
        for goal in DataModel.shared.activeGoals {
            let firstMilestone = goal.sortedMilestones.first!
            let milestones = goal.milestones.filter { $0 !== firstMilestone }
            
            for milestone in milestones {
                XCTAssertEqual(milestone.state, .active)
            }
        }
    }
    
    
    //Summit Milestone
    
    func test_milestones_contains_summitMilestone() {
        for goal in DataModel.shared.activeGoals {
            let summitMilestone = goal.milestones.filter { $0.image == .summit }.first
            
            XCTAssertNotNil(summitMilestone)
        }
    }
    
    
    func test_summitMilestone_neededStepUnits_equalTo_goal_neededStepUnits() {
        for goal in DataModel.shared.activeGoals {
            let summitMilestone = goal.milestones.filter { $0.image == .summit }.first!
            
            XCTAssertEqual(Double(goal.neededStepUnits), summitMilestone.neededStepUnits)
        }
    }
    
    
    //NeededSteps between Milestones Invariant: Steps between ASC milestones are monotonic increasing
    
    func test_stepsBetween_ASC_milestones_are_monotonic_increasing() {
        for goal in DataModel.shared.activeGoals {
            let stepsInBetweenArray = goal.sortedMilestones.map { Int($0.stepsFromPrev) }
            
            XCTAssertTrue(TestsHelper.isSortedASC(array: stepsInBetweenArray))
        }
    }
    
    
    func test_stepsBetween_ASC_milestones_are_greaterThan_zero() {
        for goal in DataModel.shared.activeGoals {
            let stepsInBetweenArray = goal.sortedMilestones.map { Int($0.stepsFromPrev) }
            
            stepsInBetweenArray.forEach { XCTAssertGreaterThan($0, 0) }
        }
    }
}

