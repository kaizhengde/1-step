//
//  GoalModel.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

final class GoalModel: TransitionObservableObject {
    
    @Published var transition: TransitionManager<GoalModel> = TransitionManager()
    @Published var selectedGoal: Goal!
    
    
    //MARK: - Transition
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: DelayAfter.mountainAppear, fullHideAfter: .never)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    //MARK: - Summary
    
    func mountainTransitionOffset() -> CGFloat {
        return MountainLayout.offsetY + (transition.didAppear ? 0 : MountainLayout.height)
    }
    
    
    
}
