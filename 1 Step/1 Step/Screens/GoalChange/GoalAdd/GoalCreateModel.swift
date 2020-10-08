//
//  GoalAddModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI
import Combine

enum GoalCreateStage {
    case selectMountain, enterInput
}


final class GoalCreateModel: ObservableObject, GoalSelectMountainDelegate {
    
    @Published var goalCreateStage: GoalCreateStage = .selectMountain
    
    @Published var selectedMountainData: GoalSelectMountainData = (nil, .user0)
    
    
    func dismissGoalSelectMountainView() {
        goalCreateStage = .enterInput
    }
    
    //MARK: - Transition
    
    var backButtonOpacity: Double { goalCreateStage == .enterInput ? 1.0 : 0.0 }
}


