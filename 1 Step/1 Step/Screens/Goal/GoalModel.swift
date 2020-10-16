//
//  GoalModel.swift
//  1 Step
//
//  Created by Kai Zheng on 16.10.20.
//

import SwiftUI

final class GoalModel: TransitionObservableObject {
    
    @Published var transition: TransitionManager<GoalModel> = TransitionManager<GoalModel>()
    
    
    //MARK: - Transition
    
    func initTransition() {
        print("Transition Start")
    }
    
    
    
}
