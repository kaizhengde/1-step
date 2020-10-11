//
//  GoalErrorHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import Foundation

struct GoalErrorHandler {
    
    enum GoalError: Error {
        case goalNameEmpty
        
        case stepsNeededEmpty
        case stepsNeededTooLittle
        case stepsNeededTooMany
        
        case stepCategoryEmpty
        case stepUnitEmpty
        case stepCustomUnitEmpty
    }
    
    
    static func hasErrors(with changeData: Goal.ChangeData) -> Bool {
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
            errorText =  "Too little steps to take, maybe change the unit (km -> m)?\n\nMinimum steps: \(Goal.stepsNeededMinimum)."
        }
        catch GoalError.stepsNeededTooMany {
            errorText =  "Too many steps to take, maybe change the unit (m -> km)?\n\nMaximum steps: \(Goal.stepsNeededMaximum)."
        }
        catch {
            errorText = "Goal create failed with an unknown error.\n\nConsider restarting the app."
        }
        
        PopupManager.shared.showTextPopup(titleText: "Oh Deer", titleImage: Emoji.deer, bodyText: errorText, backgroundColor: changeData.color!.get())
        
        return true
    }
    
    
    static func correctInput(with changeData: Goal.ChangeData) throws {
        
        if changeData.name.isEmpty { throw GoalError.goalNameEmpty }
        if changeData.stepsNeeded == nil { throw GoalError.stepsNeededEmpty }
        if changeData.stepCategory == nil { throw GoalError.stepCategoryEmpty }
        if changeData.stepUnit == nil { throw GoalError.stepUnitEmpty }
        if changeData.stepCustomUnit.isEmpty && changeData.stepUnit! == .custom { throw GoalError.stepCustomUnitEmpty }
        
        if changeData.stepsNeeded! < Goal.stepsNeededMinimum {
            throw GoalError.stepsNeededTooLittle
        }
        if changeData.stepsNeeded! > Goal.stepsNeededMaximum {
            throw GoalError.stepsNeededTooMany
        }
    }
}
