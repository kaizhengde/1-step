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
    
    @Published var currentView: GoalInfoCurrent
    let initialView: GoalInfoCurrent
    
    
    init(initialView: GoalInfoCurrent) {
        self.initialView = initialView
        self.currentView = initialView
    }
    
    
    //MARK: - How it works
    
    //One
    
    lazy var howItWorksTextPassageOneData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "1 Step is about reaching your goals with simplicity and intelligence.", textArt: .standard),
        OneSTextPassageData(text: "The main idea is to break your goals into tiny steps, with each step requiring minimal willpower for you to act on.", textArt: .bold),
        OneSTextPassageData(text: "For instance losing weight. We could instead set a goal to hike every mountain nearby. Maybe every mountain in the swiss alps.", textArt: .standard),
        OneSTextPassageData(text: "Every step would be equivalent to hiking one mountain. Far more appealing!", textArt: .bold),
        OneSTextPassageData(text: "Certainly, as you have hiked all these mountains, you will have lost some weight.", textArt: .standard)
    ]
    
    lazy var howItWorksExampleOneData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Lose weight", arrowText: "", final: false),
        GoalExampleData(backgroundText: "Hike every mountain in the swiss alps", arrowText: "", final: true)
    ]
    
    //Two
    
    lazy var howItWorksTextPassageTwoData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "A different example could be to read more books. You could instead say to read ten thousand pages in total.", textArt: .standard),
        OneSTextPassageData(text: "This will grant you a whole new perspective. Instead of looking at whole books, we are simply focusing our attention on one single page.", textArt: .standard),
        OneSTextPassageData(text: "You can always read one single page!", textArt: .bold)
    ]
    
    lazy var howItWorksExampleTwoData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Read more books", arrowText: "", final: false),
        GoalExampleData(backgroundText: "Read 10.000 pages in total", arrowText: "", final: true)
    ]
    
    //Three
    
    lazy var howItWorksTextPassageThreeData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "Rather than being in front of a big mountain, we are enjoying our way to the summit with small, joyful steps.", textArt: .background),
        OneSTextPassageData(text: "In the following, we will show you a great strategy that will get you an excellent formulation for your goal.", textArt: .standard),
        OneSTextPassageData(text: "Let's again look at losing weight as our example.", textArt: .standard),
        OneSTextPassageData(text: "I want to...", textArt: .bold)
    ]
    
    lazy var howItWorksExampleThreeData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Lose weight", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Lose 20 pounds", arrowText: "How?", final: false),
        GoalExampleData(backgroundText: "Exercise more often", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Hike every mountain in the swiss alps", arrowText: "", final: true)
    ]
    
    lazy var howItWorksTextPassageFourData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "Basically all we do is to continually ask ourselves how we can specify what it is that we want to achieve and how we can actually get there.", textArt: .standard),
        OneSTextPassageData(text: "The idea is then to reach a point where we have something that is trackable. Hence we can now take tiny steps to move closer and closer towards our goal.", textArt: .standard),
        OneSTextPassageData(text: "Sure, you can be as creative as you want. Choose whatever motivates you the most!", textArt: .background),
    ]
    
    lazy var howItWorksExampleFourData: [GoalExampleData] = [
        GoalExampleData(backgroundText: "Go for a run regularly", arrowText: "What?", final: false),
        GoalExampleData(backgroundText: "Run 100 miles", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run 300 times", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Run to 50 parks", arrowText: "", final: true),
        GoalExampleData(backgroundText: "Hike 12 mountains in the swiss alps", arrowText: "", final: true)
    ]
    
    lazy var howItWorksTextPassageFiveData: [OneSTextPassageData] = [
        OneSTextPassageData(text: "And that's it!", textArt: .bold),
        OneSTextPassageData(text: "We wish you great joy with 1 Step.", textArt: .standard)
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
