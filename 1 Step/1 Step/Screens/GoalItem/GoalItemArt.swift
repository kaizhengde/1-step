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
        if MainModel.shared.currentScreen.active.isScreen(.goal(.showActive)) { return .menu }
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
        case .menu: return 165
        }
    }
    
    
    static let padding: CGFloat = 12
    
    
    static var shape = RoundedRectangle(cornerRadius: 12, style: .continuous)
    
    
    static func color(_ isCurrentDrag: Bool, of goal: Goal) -> Color {
        return isCurrentDrag ? Color.lightNeutralToLightGray : goal.color.standard
    }
    
    //Text
    
    static var nameFont: OneSFont {
        switch current {
        case .grid: return .custom(.extraBold, 21)
        case .menu: return .custom(.extraBold, 17)
        }
    }
    
    
    static var stepsFont: OneSFont {
        switch current {
        case .grid: return .custom(.regular, 15)
        case .menu: return .custom(.regular, 13.5)
        }
    }
    
    
    static var textOffset: CGFloat {
        switch current {
        case .grid: return 36
        case .menu: return 8
        }
    }
    
    
    static var textWidth: CGFloat {
        return width-padding*2
    }
    

    //Mountain
    
    static func mountainOffset(_ percent: Int16) -> CGFloat {
        var offset: CGFloat = 0
        
        switch current {
        case .grid: offset = 120*Layout.multiplierWidth
        case .menu: offset = 70
        }
        
        return generateDynamicOffset(with: offset, percent)
    }
    
    
    static func generateDynamicOffset(with offset: CGFloat, _ percent: Int16) -> CGFloat {
        let mountainPositionRange = height - offset
        let dynamicOffset = mountainPositionRange * CGFloat(percent)/100
        
        return offset + mountainPositionRange - dynamicOffset
    }
}
