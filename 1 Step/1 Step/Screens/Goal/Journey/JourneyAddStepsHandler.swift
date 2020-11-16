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
    
    enum AddStepsResult: Equatable {
        case normal
        case milestoneChange(forward: Bool)
        case goalDone
        
        
        var isMilestoneChange: Bool {
            return self == .milestoneChange(forward: true) || self == .milestoneChange(forward: false)
        }
    }
    
    func getAddStepsResult(with newStepUnits: Double) -> AddStepsResult {
        let currentMilestone = goal.milestones.filter { $0.state == .current }.first!
                
        let prevMilestoneNeededStepUnits = currentMilestone.neededStepUnits - currentMilestone.stepUnitsFromPrev
        
        if currentMilestone.neededStepUnits <= goal.currentStepUnits + newStepUnits {
            return .milestoneChange(forward: true)
        } else if prevMilestoneNeededStepUnits > goal.currentStepUnits + newStepUnits && goal.currentStepUnits > 0 {
            return .milestoneChange(forward: false)
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
        case openNewAndScrollToCurrent
    }

    
    func after(_ changeState: MilestoneChangeState) -> Double {
        switch changeState {
        case .none:                         return 0.0
        case .closeFinished:                return 0.6
        case .openNewAndScrollToCurrent:    return 1.2
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    GoalModel.shared.setScrollPosition.send(.current)
                }
            }
        }
    }
    
    
    func startMilestoneChange(forward: Bool) {
        milestoneChangeState = .closeFinished
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.closeFinished)) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
            
            if forward {
                FloaterManager.shared.showTextFloater(
                    titleText: "Congratz 🎉",
                    bodyText: "You have reached \(self.goal.currentStepUnits.toUI()) \(self.goal.step.unit == .custom ? self.goal.step.customUnit : self.goal.step.unit.description)!",
                    backgroundColor: self.goal.color.get(.light)
                )
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.openNewAndScrollToCurrent)) {
            self.milestoneChangeState = .none
        }
    }
}
