//
//  GoalItemModel.swift
//  1 Step
//
//  Created by Kai Zheng on 12.10.20.
//

import SwiftUI

enum GoalItemArt {

    case grid, menu
    
    static var current: GoalItemArt {
        if MainModel.shared.currentScreen.active.isScreen(.goals) { return .grid }
        if MainModel.shared.currentScreen.active.isScreen(.goal(.appear)) { return .menu }
        return .grid
    }
    
    
    static var width: CGFloat {
        switch current {
        case .grid: return 145*Layout.multiplierWidth
        case .menu: return 112
        }
    }
    
    
    static var height: CGFloat {
        switch current {
        case .grid: return 250*Layout.multiplierWidth
        case .menu: return 160
        }
    }
    
    
    static var shape = RoundedRectangle(cornerRadius: 12, style: .continuous)
    
    
    static func color(_ isCurrentDrag: Bool, of goal: Goal) -> Color {
        return isCurrentDrag ? Color.lightNeutralToLightGray : goal.color.get()
    }
    
    //Text
    
    static func stepUnitText(_ goal: Goal) -> String {
        return goal.step.unit == .custom ? goal.step.customUnit : goal.step.unit.description
    }
    
    
    static var nameFont: OneSFont {
        switch current {
        case .grid: return .custom(weight: Raleway.extraBold, size: 20)
        case .menu: return .custom(weight: Raleway.extraBold, size: 17)
        }
    }
    
    
    static var stepsFont: OneSFont {
        switch current {
        case .grid: return .custom(weight: Raleway.regular, size: 15)
        case .menu: return .custom(weight: Raleway.regular, size: 13.5)
        }
    }
    
    
    static var textOffset: CGFloat {
        switch current {
        case .grid: return 36
        case .menu: return 16
        }
    }
    

    //Mountain
    
    static func mountainOffset(_ goal: Goal) -> CGFloat {
        var offset: CGFloat = 0
        
        switch current {
        case .grid: offset = 120*Layout.multiplierWidth
        case .menu: offset = 85*Layout.multiplierWidth
        }
        
        return generateDynamicOffset(with: offset, goal)
    }
    
    
    static func generateDynamicOffset(with offset: CGFloat, _ goal: Goal) -> CGFloat {
        let mountainPositionRange = height - offset
        let dynamicOffset = mountainPositionRange * CGFloat(goal.currentPercent)/100
        
        return offset + mountainPositionRange - dynamicOffset
    }
}
