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
    
    var currentMilestone: Milestone {
        goal.milestones.filter { $0.state == .current }.first ?? Milestone(context: PersistenceManager.defaults.context)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.opacity) {
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
                titleText:          "\(RandomText.congrats()) 🎉",
                bodyText:           "\(Localized.AddStepsAccomplishment.milestoneTextPre) \(currentMilestone.neededStepUnits.toUI()) \(goal.step.unitDescription) \(Localized.AddStepsAccomplishment.milestoneTextPost)!",
                backgroundColor:    goal.color.light
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
        case finalPopup
    }
    
    
    func after(goalReachedState: GoalReachedState) -> Double {
        switch goalReachedState {
        case .none:                             return 0.0
        case .closeSummit:                      return 0.9
        case .scrollToTopAndStartFlagAnimation: return 3.6
        case .finalPopup:                       return 4.2
        }
    }
    
    
    @Published var goalReachedState: GoalReachedState = .none {
        didSet {
            if goalReachedState == .closeSummit {
                milestoneChangeState = .closeFinished
                goalReached.send()
                
            } else if goalReachedState == .scrollToTopAndStartFlagAnimation {
                self.milestoneChangeState = .none
                GoalModel.shared.setScrollPosition.send(.top)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.oneS) {
                    self.startGoalReachedFlagAnimation()
                }
                
            } else if goalReachedState == .finalPopup {
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
            self.goalReachedState = .finalPopup
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after(goalReachedState: .finalPopup)) {
            self.goalReachedState = .none
        }
    }
    
    
    private func startGoalReachedFlagAnimation() {
        GoalModel.shared.showFlag = true
        GoalModel.shared.objectWillChange.send()
    }
    
    
    private func startGoalReachedUIAnimations() {
        PopupManager.shared.showPopup(.goalReached, backgroundColor: goal.color.standard, height: 400*Layout.multiplierWidth, dismissOnTapOutside: false) {
            OneSTextPopupView(
                titleText: Localized.congrats,
                bodyText: "\(Localized.AddStepsAccomplishment.completedText) \(self.goal.currentStepUnits.toUI()) \(self.goal.step.unitDescription)!",
                bottomBtnTitle: Localized.complete
            )
        }
        
        OneSFeedback.achievement()
        ConfettiManager.shared.showConfetti(amount: .big)
    }
}
