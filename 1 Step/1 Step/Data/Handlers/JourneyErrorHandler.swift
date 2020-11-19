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
    
    
    static func addHasErrors(with goal: Goal, newStepUnits: Double) -> Bool {
        
        let newCurrentUnits = goal.currentStepUnits + newStepUnits
        
        if newCurrentUnits < 0 {
            PopupManager.shared.showTextPopup(.none, titleText: "Oh Deer", titleImage: Emoji.deer, bodyText: "You can't have negative steps.", backgroundColor: goal.color.get())
            
            return true
        }
        return false
    }
}
