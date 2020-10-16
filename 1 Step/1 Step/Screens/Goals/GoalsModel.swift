//
//  GoalsScreenModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum GoalsTab: String {
    
    case active = "Active"
    case reached = "Reached"
    
    var description: String { return self.rawValue }
    
    
    mutating func toggle() {
        if self == .active { self = .reached }
        else { self = .active }
    }
}


final class GoalsModel: ObservableObject {
    
    @Published var currentTab: GoalsTab = .active
    
    
    //MARK: - Scroll
    
    var scrollViewBottomPadding: CGFloat {
        let count = currentTab == .active ? DataModel.shared.activeGoals.count : DataModel.shared.reachedGoals.count
        return count < 2 ? 0 : 300*Layout.multiplierHeight
    }
}
