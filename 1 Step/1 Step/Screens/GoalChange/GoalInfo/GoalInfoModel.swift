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
        case .howItWorks:   return Localized.howItWorks
        case .examples:     return Localized.examples
        }
    }
}


struct GoalExampleData {
    
    let text: String
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
    
    struct HowItWorksData {
                
        static let textPassageOne: [OneSTextPassageData] = [
            OneSTextPassageData(text: Localized.HowItWorks.textPassageOne1, textArt: .standard),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageOne2, textArt: .standard),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageOne3, textArt: .background),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageOne4, textArt: .bold),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageOne5, textArt: .standard)
        ]
        
        
        static let exampleOne: [GoalExampleData] = [
            GoalExampleData(text: Localized.HowItWorks.exampleOne1, arrowText: "", final: false),
            GoalExampleData(text: Localized.HowItWorks.exampleOne2, arrowText: "", final: true)
        ]
        
        
        static let textPassageTwo: [OneSTextPassageData] = [
            OneSTextPassageData(text: Localized.HowItWorks.textPassageTwo1, textArt: .standard)
        ]
        
        
        static let exampleTwo: [GoalExampleData] = [
            GoalExampleData(text: Localized.HowItWorks.exampleTwo1, arrowText: "", final: false),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo2, arrowText: "", final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo3, arrowText: "", final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo4, arrowText: "", final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo5, arrowText: "", final: true)
        ]
        
        
        static let textPassageThree: [OneSTextPassageData] = [
            OneSTextPassageData(text: Localized.HowItWorks.textPassageThree1, textArt: .standard),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageThree2, textArt: .background),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageThree3, textArt: .bold),
            OneSTextPassageData(text: Localized.HowItWorks.textPassageThree4, textArt: .standard)
        ]
    }
    
    
    //MARK: - Examples
    
    struct ExamplesData {
        
        static let examples: [(example: String, data: [GoalExampleData])] = [
            (example: "Lose weight",            data: loseWeight),
            (example: "Become more self-aware", data: selfAware),
            (example: "Help the environment",   data: helpEnvironment),
            (example: "Get better at guitar",   data: betterAtGuitar),
            (example: "Be more happy",          data: moreHappy),
            (example: "Stop procrastination",   data: stopProcrastination),
            (example: "Learn a new language",   data: newLanguage),
            (example: "Increase my knowledge",  data: moreKnowledge)
        ]
        
        
        private static let loseWeight: [GoalExampleData] = [
            GoalExampleData(text: "Lose weight",              arrowText: "What?", final: false),
            GoalExampleData(text: "Lose 20 pounds",           arrowText: "How?",  final: false),
            GoalExampleData(text: "Exercise more often",      arrowText: "What?", final: false),
            GoalExampleData(text: "Go for a run regularly",   arrowText: "What?", final: false),
            GoalExampleData(text: "Run 100 miles",            arrowText: "",      final: true),
            GoalExampleData(text: "Run 300 times",            arrowText: "",      final: true),
            GoalExampleData(text: "Run to 50 parks",          arrowText: "",      final: true),
            GoalExampleData(text: "Hike 12 mountains",        arrowText: "",      final: true)
        ]
        
        
        private static let selfAware: [GoalExampleData] = [
            GoalExampleData(text: "Become more self-aware",           arrowText: "What?", final: false),
            GoalExampleData(text: "Practise mindfulness",             arrowText: "How?",  final: false),
            GoalExampleData(text: "Start meditating regularly",       arrowText: "What?", final: false),
            GoalExampleData(text: "Meditate 50 hours",                arrowText: "",      final: true),
            GoalExampleData(text: "Meditate 100 times",               arrowText: "",      final: true),
            GoalExampleData(text: "Breathe in deeply 10.000 times",   arrowText: "",      final: true),
            GoalExampleData(text: "Acknowledge the now 10.000 times", arrowText: "",      final: true)
        ]
        
        
        private static let helpEnvironment: [GoalExampleData] = [
            GoalExampleData(text: "Help the environment",                 arrowText: "How?",  final: false),
            GoalExampleData(text: "Plant 100 trees",                      arrowText: "",      final: true),
            GoalExampleData(text: "Save rainforest 10 square miles",   arrowText: "",      final: true),
            GoalExampleData(text: "Collect trash 1.000 times",            arrowText: "",      final: true),
            GoalExampleData(text: "Eat a vegan meal 100 times",           arrowText: "",      final: true)
        ]
        
        
        private static let betterAtGuitar: [GoalExampleData] = [
            GoalExampleData(text: "Get better at guitar",     arrowText: "How?",  final: false),
            GoalExampleData(text: "Play 100 new songs",       arrowText: "",      final: true),
            GoalExampleData(text: "Play 100 hours",           arrowText: "",      final: true),
            GoalExampleData(text: "Watch 10 Youtube videos",  arrowText: "",      final: true)
        ]
        
        
        private static let moreHappy: [GoalExampleData] = [
            GoalExampleData(text: "Be more happy",                arrowText: "How?",  final: false),
            GoalExampleData(text: "Give back and help others",    arrowText: "What?", final: false),
            GoalExampleData(text: "Collect trash 1.000 times",    arrowText: "",      final: true),
            GoalExampleData(text: "Rescue an insect 1.000 times", arrowText: "",      final: true),
            GoalExampleData(text: "Help a friend 100 times",      arrowText: "",      final: true),
            GoalExampleData(text: "Say thank you 10.000 times",   arrowText: "",      final: true)
        ]
        
        
        private static let stopProcrastination: [GoalExampleData] = [
            GoalExampleData(text: "Stop procrastination",                     arrowText: "What?", final: false),
            GoalExampleData(text: "Start doing the right thing instantly",    arrowText: "How?",  final: false),
            GoalExampleData(text: "Train my instant decision making muscle",  arrowText: "How?",  final: false),
            GoalExampleData(text: "Make 10.000 instant descisions",           arrowText: "",      final: true),
            GoalExampleData(text: "Journal on progress 100 times",            arrowText: "",      final: true),
        ]
        
        
        private static let newLanguage: [GoalExampleData] = [
            GoalExampleData(text: "Learn a new language",                         arrowText: "How?",  final: false),
            GoalExampleData(text: "Interact more frequently with [language]",     arrowText: "How?",  final: false),
            GoalExampleData(text: "Watch 100 movies in [language]",               arrowText: "",      final: true),
            GoalExampleData(text: "Listen to [language] podcasts 1.000 times",    arrowText: "",      final: true),
            GoalExampleData(text: "Speak to 100 [language] people",               arrowText: "",      final: true)
        ]
        
        
        private static let moreKnowledge: [GoalExampleData] = [
            GoalExampleData(text: "Increase my knowledge",  arrowText: "How?",  final: false),
            GoalExampleData(text: "Read more books",        arrowText: "What?", final: false),
            GoalExampleData(text: "Read 10.000 pages",      arrowText: "",      final: true),
            GoalExampleData(text: "Read 1.000 times",       arrowText: "",      final: true)
        ]
    }
}
