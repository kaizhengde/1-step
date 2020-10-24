//
//  GoalErrorHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import Foundation

enum GoalErrorHandler {
    
    enum GoalError: Error {
        case goalNameEmpty
        
        case stepsNeededEmpty
        case stepsNeededTooLittle
        case stepsNeededTooMany
        
        case stepCategoryEmpty
        case stepUnitEmpty
        case stepCustomUnitEmpty
    }
    
    
    static func hasErrors(with changeData: Goal.BaseData) -> Bool {
        let errorText: String!
        
        do {
            try correctInput(with: changeData)
            return false
        }
        catch GoalError.goalNameEmpty {
            errorText = "What do you want to achieve?\n\nPlease enter a goal."
        }
        catch GoalError.stepsNeededEmpty {
            errorText = "How many steps does it take to reach your goal?\n\nPlease enter a number."
        }
        catch GoalError.stepCategoryEmpty, GoalError.stepUnitEmpty {
            errorText = "What do you want to track?\n\nPlease select a unit."
        }
        catch GoalError.stepCustomUnitEmpty {
            errorText = "Your custom unit is empty?\n\nPlease re enter."
        }
        catch GoalError.stepsNeededTooLittle {
            errorText =  "Too little steps to take.?\n\nMinimum steps: \(Goal.stepsNeededMinimum)."
        }
        catch GoalError.stepsNeededTooMany {
            errorText =  "Too many steps to take.?\n\nMaximum steps: \(Goal.stepsNeededMaximum)."
        }
        catch {
            errorText = "Goal create failed with an unknown error.\n\nConsider restarting the app."
        }
        
        PopupManager.shared.showTextPopup(titleText: "Oh Deer", titleImage: Emoji.deer, bodyText: errorText, backgroundColor: changeData.color!.get())
        
        return true
    }
    
    
    static func correctInput(with baseData: Goal.BaseData) throws {
        
        if baseData.name.isEmpty { throw GoalError.goalNameEmpty }
        if baseData.neededStepUnits == nil { throw GoalError.stepsNeededEmpty }
        if baseData.stepCategory == nil { throw GoalError.stepCategoryEmpty }
        if baseData.stepUnit.isEmpty { throw GoalError.stepUnitEmpty }
        if baseData.stepUnit == "custom" { throw GoalError.stepCustomUnitEmpty }
        
        if baseData.neededStepUnits! < Goal.stepsNeededMinimum {
            throw GoalError.stepsNeededTooLittle
        }
        if baseData.neededStepUnits! > Goal.stepsNeededMaximum {
            throw GoalError.stepsNeededTooMany
        }
    }
}
