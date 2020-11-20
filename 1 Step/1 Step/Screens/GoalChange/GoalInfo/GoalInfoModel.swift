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
    
    lazy var howItWorksTextPassageOneData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "When it comes down to reaching a goal, one of the most important things is actually the formulation.", textArt: .standard),
        OneSTextPassageData(text: "Even more - having a intelligent formulation for your goal will pretty much decide, whether you succeed or not.", textArt: .standard),
        OneSTextPassageData(text: "In the following, we will show you a proven strategy that will get you an excellent formulation.", textArt: .bold),
        OneSTextPassageData(text: "This strategy has brought surprising success to thousands of people world wide. The concept is simple, here is how it works:", textArt: .standard),
        OneSTextPassageData(text: "It’s all about tiny steps you can take and track. The key is to be specific.", textArt: .background),
        OneSTextPassageData(text: "I want to...", textArt: .bold),
    ]
    
    lazy var howItWorksExampleOneData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Lose weight", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Lose 20 pounds", arrowText: "How?", final: false),
        GoalExampleData(backgroundText: "Exercise more often", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles in total", arrowText: "", final: true)
    ]
    
    lazy var howItWorksTextPassageTwoData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "Basically all we do is to continually ask ourselves how we can specify what it is that we want to achieve and how we can actually get there.", textArt: .standard),
        OneSTextPassageData(text: "The main idea is then to reach a point where we have something that is trackable. Hence we can now take tiny steps to move closer and closer towards our goal.", textArt: .standard),
        OneSTextPassageData(text: "Sure, you can be as creative as you want. Choose whatever motivates you the most!", textArt: .background),
    ]
    
    lazy var howItWorksExampleTwoData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run 300 times", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run to 50 parks", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Hike 12 mountains", arrowText: "", final: true)
    ]
    
    lazy var howItWorksTextPassageThreeData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "And that's it!", textArt: .bold)
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
