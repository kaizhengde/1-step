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
    let arrowText: ArrowText
    let final: Bool
    
    init(text: String, arrowText: ArrowText = .none, final: Bool = false) {
        self.text = text
        self.arrowText = arrowText
        self.final = final
    }
    
    
    enum ArrowText {
        
        case how, what, none
        
        var description: String {
            switch self {
            case .how:  return "\(Localized.how)?"
            case .what: return "\(Localized.what)?"
            case .none: return ""
            }
        }
    }
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
            GoalExampleData(text: Localized.HowItWorks.exampleOne1),
            GoalExampleData(text: Localized.HowItWorks.exampleOne2, final: true)
        ]
        
        
        static let textPassageTwo: [OneSTextPassageData] = [
            OneSTextPassageData(text: Localized.HowItWorks.textPassageTwo1, textArt: .standard)
        ]
        
        
        static let exampleTwo: [GoalExampleData] = [
            GoalExampleData(text: Localized.HowItWorks.exampleTwo1),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo2, final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo3, final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo4, final: true),
            GoalExampleData(text: Localized.HowItWorks.exampleTwo5, final: true)
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
            (example: Localized.Examples.oneTitle,      data: loseWeight),
            (example: Localized.Examples.twoTitle,      data: selfAware),
            (example: Localized.Examples.threeTitle,    data: helpEnvironment),
            (example: Localized.Examples.fourTitle,     data: betterAtGuitar),
            (example: Localized.Examples.fiveTitle,     data: moreHappy),
            (example: Localized.Examples.sixTitle,      data: stopProcrastination),
            (example: Localized.Examples.sevenTitle,    data: newLanguage),
            (example: Localized.Examples.eightTitle,    data: moreKnowledge)
        ]
        
        
        private static let loseWeight: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.oneText1, arrowText: .what),
            GoalExampleData(text: Localized.Examples.oneText2, arrowText: .how),
            GoalExampleData(text: Localized.Examples.oneText3, arrowText: .what),
            GoalExampleData(text: Localized.Examples.oneText4, final: true),
            GoalExampleData(text: Localized.Examples.oneText5, final: true),
            GoalExampleData(text: Localized.Examples.oneText6, final: true),
            GoalExampleData(text: Localized.Examples.oneText7, final: true),
        ]
        
        
        private static let selfAware: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.twoText1, arrowText: .what),
            GoalExampleData(text: Localized.Examples.twoText2, arrowText: .how),
            GoalExampleData(text: Localized.Examples.twoText3, arrowText: .what),
            GoalExampleData(text: Localized.Examples.twoText4, final: true),
            GoalExampleData(text: Localized.Examples.twoText5, final: true),
            GoalExampleData(text: Localized.Examples.twoText6, final: true),
            GoalExampleData(text: Localized.Examples.twoText7, final: true)
        ]
        
        
        private static let helpEnvironment: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.threeText1, arrowText: .how),
            GoalExampleData(text: Localized.Examples.threeText2, final: true),
            GoalExampleData(text: Localized.Examples.threeText3, final: true),
            GoalExampleData(text: Localized.Examples.threeText4, final: true),
            GoalExampleData(text: Localized.Examples.threeText5, final: true)
        ]
        
        
        private static let betterAtGuitar: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.fourText1, arrowText: .how),
            GoalExampleData(text: Localized.Examples.fourText2, final: true),
            GoalExampleData(text: Localized.Examples.fourText3, final: true),
            GoalExampleData(text: Localized.Examples.fourText4, final: true)
        ]
        
        
        private static let moreHappy: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.fiveText1, arrowText: .how),
            GoalExampleData(text: Localized.Examples.fiveText2, arrowText: .what),
            GoalExampleData(text: Localized.Examples.fiveText3, final: true),
            GoalExampleData(text: Localized.Examples.fiveText4, final: true),
            GoalExampleData(text: Localized.Examples.fiveText5, final: true),
        ]
        
        
        private static let stopProcrastination: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.sixText1, arrowText: .what),
            GoalExampleData(text: Localized.Examples.sixText2, arrowText: .how),
            GoalExampleData(text: Localized.Examples.sixText3, arrowText: .how),
            GoalExampleData(text: Localized.Examples.sixText4, final: true),
            GoalExampleData(text: Localized.Examples.sixText5, final: true),
        ]
        
        
        private static let newLanguage: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.sevenText1, arrowText: .how),
            GoalExampleData(text: Localized.Examples.sevenText2, arrowText: .how),
            GoalExampleData(text: Localized.Examples.sevenText3, final: true),
            GoalExampleData(text: Localized.Examples.sevenText4, final: true),
        ]
        
        
        private static let moreKnowledge: [GoalExampleData] = [
            GoalExampleData(text: Localized.Examples.eightText1, arrowText: .how),
            GoalExampleData(text: Localized.Examples.eightText2, arrowText: .what),
            GoalExampleData(text: Localized.Examples.eightText3, final: true),
            GoalExampleData(text: Localized.Examples.eightText4, final: true)
        ]
    }
}
