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
    
    var isActive: Bool { return self == .active }
    var isReached: Bool { return self == .reached }
}


final class GoalsModel: ObservableObject {
    
    @Published var currentTab: GoalsTab = .active
    
    init() {
        DataModel.shared.updateReachedGoalsPercentage()
    }
    
    
    //MARK: - Scroll
    
    var scrollViewBottomPadding: CGFloat {
        let count = currentTab == .active ? DataModel.shared.activeGoals.count : DataModel.shared.reachedGoals.count
        return count < 2 ? 0 : 260*Layout.multiplierHeight
    }
}
