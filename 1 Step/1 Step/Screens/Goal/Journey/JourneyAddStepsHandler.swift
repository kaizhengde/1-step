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
        } else if prevMilestoneNeededStepUnits > goal.currentStepUnits + newStepUnits && goal.currentStepUnits > 0 {
            return .milestoneChange
        }
        
        return .normal
    }
    
    
    //MARK: - Normal Add
    
    let normalAdd = ObjectWillChangePublisher()
    
    func startNormalAdd() {
        normalAdd.send()
        GoalModel.shared.setScrollPosition.send(.current)
    }
    
    
    
    //MARK: - MilestoneChange
    
    enum MilestoneChangeState {
        case none
        case closeFinished
        case wait
        case openNewAndScrollToCurrent
    }

    
    func after(_ changeState: MilestoneChangeState) -> Double {
        switch changeState {
        case .none:                         return 0.0
        case .closeFinished:                return 0.6
        case .wait:                         return 1.2
        case .openNewAndScrollToCurrent:    return 1.8
        }
    }
    
    
    var hideMilestoneView: Bool {
        return milestoneChangeState == .closeFinished
    }
    
    var hideDoneMilestoneItems: Bool {
        return milestoneChangeState != .none
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
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.closeFinished)) {
            self.milestoneChangeState = .wait
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.wait)) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.openNewAndScrollToCurrent)) {
            self.milestoneChangeState = .none
        }
    }
}
