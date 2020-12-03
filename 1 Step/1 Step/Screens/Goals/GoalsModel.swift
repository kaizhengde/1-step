//
//  GoalsScreenModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

enum GoalsTab {
    
    case active
    case reached
    
    var description: String {
        switch self {
        case .active: return Localized.active
        case .reached: return Localized.reached
        }
    }
    
    
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
        let count = currentTab == .active ? DataModel.shared.activeGoals.count+1 : DataModel.shared.reachedGoals.count
        return count <= 2 ? 0 : 180*Layout.multiplierHeight
    }
    
    
    //MARK: - Drag and Drop
    
    struct DropOutsideDelegate: DropDelegate {
        
        @Binding var current: Goal?
        
        
        func performDrop(info: DropInfo) -> Bool {
            current = nil
            return true
        }
    }
}
