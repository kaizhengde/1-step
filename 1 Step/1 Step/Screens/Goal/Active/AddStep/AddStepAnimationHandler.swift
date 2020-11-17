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

    
    func after(milestoneChangeState: MilestoneChangeState) -> Double {
        switch milestoneChangeState {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after(milestoneChangeState: .closeFinished)) {
            self.milestoneChangeState = .openNewAndScrollToCurrent
            self.startMilestoneChangeUIAnimations(forward)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after(milestoneChangeState: .openNewAndScrollToCurrent)) {
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
    
    let goalReached = ObjectWillChangePublisher()
    
    
    enum GoalReachedState {
        case none
        case closeSummit
        case scrollToTopAndStartFlagAnimation
        case uIAnimations
    }
    
    
    func after(goalReachedState: GoalReachedState) -> Double {
        switch goalReachedState {
        case .none:                             return 0.0
        case .closeSummit:                      return 0.6
        case .scrollToTopAndStartFlagAnimation: return 3.0
        case .uIAnimations:                     return 3.6
        }
    }
    
    
    @Published var goalReachedState: GoalReachedState = .none {
        didSet {
            if goalReachedState == .closeSummit {
                milestoneChangeState = .closeFinished
                goalReached.send()
            } else if goalReachedState == .scrollToTopAndStartFlagAnimation {
                GoalModel.shared.setScrollPosition.send(.top)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.startGoalReachedFlagAnimation()
                }
            } else if goalReachedState == .uIAnimations {
                self.startGoalReachedUIAnimations()
            }
        }
    }
    
    
    func startGoalReached() {
        goalReachedState = .closeSummit
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after(goalReachedState: .closeSummit)) {
            self.goalReachedState = .scrollToTopAndStartFlagAnimation
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(goalReachedState: .scrollToTopAndStartFlagAnimation)) {
            self.goalReachedState = .uIAnimations
        }
    }
    
    
    private func startGoalReachedFlagAnimation() {
        
    }
    
    
    private func startGoalReachedUIAnimations() {
        FloaterManager.shared.showTextFloater(
            titleText: "Congratz 🎉",
            bodyText: "You have reached \(self.goal.currentStepUnits.toUI()) \(self.goal.step.unit == .custom ? self.goal.step.customUnit : self.goal.step.unit.description)!",
            backgroundColor: self.goal.color.get(.light)
        )
        ConfettiManager.shared.showConfetti(amount: .normal)
    }
}
