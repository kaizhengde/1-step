//
//  JourneyAddStepsHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 15.11.20.
//

import SwiftUI

class JourneyAddStepsHandler: ObservableObject {
    
    static let shared = JourneyAddStepsHandler()
    private init() {}
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    enum AddStepsResult {
        case normal
        case milestoneChange
        case goalDone
    }
    
    func getAddStepsResult(with newStepUnits: Double) -> AddStepsResult {
        let currentMilestone = goal.milestones.filter { $0.state == .current }.first!
                
        let prevMilestoneNeededStepUnits = currentMilestone.neededStepUnits - currentMilestone.stepUnitsFromPrev
        
        if currentMilestone.neededStepUnits <= goal.currentStepUnits + newStepUnits {
            return .milestoneChange
        } else if prevMilestoneNeededStepUnits > goal.currentStepUnits + newStepUnits {
            return .milestoneChange
        }
        
        return .normal
    }
    
    
    //MARK: - MilestoneChange
    
    enum MilestoneChangeState {
        case none
        case closeFinished
        case openNewAndScrollToCurrent
    }

    
    @Published var milestoneChangeState: MilestoneChangeState = .none {
        didSet {
            if milestoneChangeState == .openNewAndScrollToCurrent {
                GoalModel.shared.setScrollPosition.send(.current)
            }
        }
    }
    
    
    func startMilestoneChange() {
        milestoneChangeState = .closeFinished
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
        }
    }
}
