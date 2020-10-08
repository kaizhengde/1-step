//
//  GoalAddModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI
import Combine

enum GoalAddStage {
    case selectMountain, enterInput
}


final class GoalAddModel: ObservableObject, GoalSelectMountainDelegate {
    
    @Published var goalAddStage: GoalAddStage = .selectMountain
    
    @Published var selectedMountainData: GoalSelectMountainData = (nil, .user0)
    
    
    func dismissGoalSelectMountainView() {
        goalAddStage = .enterInput
    }
}


