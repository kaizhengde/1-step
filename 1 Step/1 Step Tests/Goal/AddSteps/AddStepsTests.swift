//
//  AddStepsTests.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

@testable import __Step
import XCTest

class AddStepsTests: XCTestCase {
    
    var persistenceManager: PersistenceManager!
    var goal: Goal!


    override func setUp() {
        super.setUp()
        
        let baseData: Goal.BaseData = (
            name: "Plant",
            stepUnit: .trees,
            customUnit: "",
            neededStepUnits: 300,
            mountain: .mountain0,
            color: .user0
        )

        _ = DataModel.shared.createGoal(with: baseData)
        goal = DataModel.shared.activeGoals[0]
    }


    override func tearDown() {
        super.tearDown()
        persistenceManager = nil
        goal = nil
    }


    //MARK: - [AddStepsModel] getAddStepsResult() -> AddStepsResult

    private func getAddStepsResult(with newStepUnits: Double) -> AddStepModel.AddStepsResult {
        let currentMilestone = goal.milestones.filter { $0.state == .current }.first!
        let prevMilestoneNeededStepUnits = currentMilestone.neededStepUnits - currentMilestone.stepUnitsFromPrev

        var newCurrentStepUnits = goal.currentStepUnits + newStepUnits

        if abs(newCurrentStepUnits - newCurrentStepUnits.rounded()) < 0.000000001 {
            newCurrentStepUnits.round()
        }

        if Int16(newCurrentStepUnits) >= goal.neededStepUnits { return .goalReached }

        if currentMilestone.neededStepUnits <= newCurrentStepUnits {
            return .milestoneChange(forward: true)
        } else if prevMilestoneNeededStepUnits > newCurrentStepUnits && goal.currentStepUnits > 0 {
            return .milestoneChange(forward: false)
        }

        return newStepUnits == 0 ? .none : (newStepUnits > 0 ? .normal(forward: true) : .normal(forward: false))
    }


    func testSimple() {
        _ = DataManager.defaults.addSteps(goal, with: 49)

        XCTAssertEqual(getAddStepsResult(with: 1), .milestoneChange(forward: true))
    }
}

