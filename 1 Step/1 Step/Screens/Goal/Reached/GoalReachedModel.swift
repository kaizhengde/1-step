//
//  GoalReachedModel.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import SwiftUI

final class GoalReachedModel: ObservableObject {
    
    static let shared = GoalReachedModel()
    private init() {}
    
    
    @Published var selectedGoal: Goal!
}
