//
//  AddStepAnimationHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 15.11.20.
//

import SwiftUI
import Combine

class AddStepAnimationHandler: ObservableObject {
    
    static let shared = AddStepAnimationHandler()
    private init() {}
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    
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
