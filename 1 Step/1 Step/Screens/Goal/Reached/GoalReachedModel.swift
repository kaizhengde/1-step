//
//  GoalReachedModel.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

final class GoalReachedModel: TransitionObservableObject {
    
    static let shared = GoalReachedModel()
    private init() {}
    
    
    @Published var selectedGoal: Goal!
    
    @Published var transition = TransitionManager<GoalReachedModel>()
    
    
    //MARK: - Transition Init
    
    func initAppear() {
        transition.state = .fullHide
    }
    
    
    func initTransition() {
        transition = TransitionManager(fullAppearAfter: Animation.Delay.mountainAppear, fullHideAfter: .never)
        transition.delegate = self
        transition.state = .firstAppear
    }
    
    
    //MARK: - Transition
    
    var mountainTransitionOffset: CGFloat {
        return MountainLayout.offsetY + (!transition.isFullHidden ? 0 : MountainLayout.height)
    }
    
    var mountainAnimation: Animation {
        return transition.isFullAppeared ? .oneSAnimation() : .oneSMountainAnimation()
    }
}
