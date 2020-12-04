//
//  AddStepsTests.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

@testable import __Step
import XCTest

class AddStepsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        super.tearDown()
    }


    //MARK: - [AddStepsModel] getAddStepsResult() -> AddStepsResult
    
//    func test_getAddStepsResult_milestoneChange_forward() {
//        let amount = 100
//        
//        GoalTestsModel.generateRandomRepsGoals(amount: amount)
//        
//        for i in 0..<amount {
//            let goal = DataModel.shared.activeGoals[i]
//            GoalModel.shared.selectedGoal = goal
//            
//            let sortedMilestones = Array(goal.milestones.sorted { $0.image.rawValue < $1.image.rawValue })
//            
//            let randomStepsBeforeMilestone: Double = sortedMilestones[Int.random(in: 0..<goal.milestones.count-1)].neededStepUnits-1
//            
//            _ = DataManager.defaults.addSteps(goal, with: randomStepsBeforeMilestone)
//            
//            let addStepModel = AddStepModel()
//            let result = addStepModel.getAddStepsResult(with: Double(Int.random(in: 1...3)))
//            
//            XCTAssertEqual(result, .milestoneChange(forward: true))
//        }
//    }
}

