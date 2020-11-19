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

class GoalInfoModel: ObservableObject {
    
    @Published var currentView: GoalInfoCurrent = .howItWorks
}
