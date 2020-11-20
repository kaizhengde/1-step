//
//  GoalInfoModel.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

enum GoalInfoCurrent {
    
    case howItWorks, examples
    
    var title: String {
        switch self {
        case .howItWorks:   return "How it works"
        case .examples:     return "Examples"
        }
    }
}


struct GoalExampleData {
    
    let backgroundText: String
    let arrowText: String
    let final: Bool
}


class GoalInfoModel: ObservableObject {
    
    @Published var currentView: GoalInfoCurrent = .howItWorks
    
    
    //MARK: - How it works
    
    lazy var howItWorksExampleOneData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Lose weight", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Lose 20 pounds", arrowText: "How?", final: false),
        GoalExampleData(backgroundText: "Exercise more often", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles in total", arrowText: "", final: true)
    ]
    
    lazy var howItWorksExampleTwoData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run 300 times", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run to 50 parks", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Hike 12 mountains", arrowText: "", final: true)
    ]
    
    
    //MARK: - Examples
    
    lazy var examples: [(example: String, data: [GoalExampleData])] = [
        (example: "Lose weight", data: loseWeightExampleData),
        (example: "Become more self-aware", data: []),
        (example: "Help the environment", data: []),
        (example: "Get better at guitar", data: []),
        (example: "Become more happy", data: []),
        (example: "Stop procrastination", data: []),
        (example: "Learn a new language", data: [])
    ]
    
    
    lazy var loseWeightExampleData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Lose weight", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Lose 20 pounds", arrowText: "How?", final: false),
        GoalExampleData(backgroundText: "Exercise more often", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run 300 times", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run to 50 parks", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Hike 12 mountains", arrowText: "", final: true)
    ]
    
}
