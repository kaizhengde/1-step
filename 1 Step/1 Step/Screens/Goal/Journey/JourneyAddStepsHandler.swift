//
//  JourneyAddStepsHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 15.11.20.
//

import SwiftUI
import Combine

class JourneyAddStepsHandler: ObservableObject {
    
    static let shared = JourneyAddStepsHandler()
    private init() {}
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    
    enum AddStepsResult: Equatable {
        
        case none 
        case normal(forward: Bool)
        case milestoneChange(forward: Bool)
        case goalDone
        
        var isMilestoneChange: Bool {
            self == .milestoneChange(forward: true) || self == .milestoneChange(forward: false)
        }
        
        var isNormal: Bool { self == .normal(forward: true) || self == .normal(forward: false) }
    }
    
    
    func getAddStepsResult(with newStepUnits: Double) -> AddStepsResult {
        let currentMilestone = goal.milestones.filter { $0.state == .current }.first!
        let prevMilestoneNeededStepUnits = currentMilestone.neededStepUnits - currentMilestone.stepUnitsFromPrev
        
        if Int16(goal.currentStepUnits + newStepUnits) >= goal.neededStepUnits { return .goalDone }
        
        if currentMilestone.neededStepUnits <= goal.currentStepUnits + newStepUnits {
            return .milestoneChange(forward: true)
        } else if prevMilestoneNeededStepUnits > goal.currentStepUnits + newStepUnits && goal.currentStepUnits > 0 {
            return .milestoneChange(forward: false)
        }
        
        return newStepUnits == 0 ? .none : (newStepUnits > 0 ? .normal(forward: true) : .normal(forward: false))
    }
    
    
    //MARK: - Normal Add
    
    let normalAdd = PassthroughSubject<Bool, Never>()
    
    func startNormalAdd(forward: Bool) {
        normalAdd.send(forward)
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
            self.startMilestoneChangeUIAnimations(forward)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.openNewAndScrollToCurrent)) {
            self.milestoneChangeState = .none
        }
    }
    
    
    private func startMilestoneChangeUIAnimations(_ forward: Bool) {
        if forward {
            FloaterManager.shared.showTextFloater(
                titleText: "Congratz 🎉",
                bodyText: "You have reached \(self.goal.currentStepUnits.toUI()) \(self.goal.step.unit == .custom ? self.goal.step.customUnit : self.goal.step.unit.description)!",
                backgroundColor: self.goal.color.get(.light)
            )
            ConfettiManager.shared.showConfetti(amount: .small)
        }
    }
    
    
    //MARK: - GoalDone
    
    func startGoalDone() {
        milestoneChangeState = .closeFinished
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.closeFinished)) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(.openNewAndScrollToCurrent)) {
            self.milestoneChangeState = .none
            #warning("To the top and flag animation!")
        }
    }
}
