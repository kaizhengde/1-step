//
//  JourneyErrorHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import Foundation

enum JourneyErrorHandler {
    
    enum JourneyError: Error {
        
        case currentStepsUnitNegative
    }
    
    
    static func addHasErrors(with goal: Goal, _ stepUnits: Double, _ stepUnitsDual: Double) -> Bool {
        
        var stepUnitsTotal = stepUnits
        if goal.step.unit.isDual { stepUnitsTotal += stepUnitsDual/goal.step.unit.dualRatio }
        
        let newCurrentUnits = goal.currentStepUnits + stepUnitsTotal
        
        if newCurrentUnits < 0 {
            PopupManager.shared.showTextPopup(titleText: "Oh Deer", titleImage: Emoji.deer, bodyText: "You can't have negative steps.", backgroundColor: goal.color.get())
            
            return true
        }
        return false
    }
}
