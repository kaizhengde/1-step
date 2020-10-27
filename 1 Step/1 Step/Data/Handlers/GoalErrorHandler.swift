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
        catch GoalError.stepUnitEmpty {
            errorText = "What do you want to track?\n\nPlease select a unit."
        }
        catch GoalError.stepCustomUnitEmpty {
            errorText = "You have entered nothing.\n\nPlease again enter a custom unit."
        }
        catch GoalError.stepsNeededTooLittle {
            errorText =  "Too little steps to take.\n\nMinimum steps: \(Goal.neededStepUnitsMinimum)."
        }
        catch GoalError.stepsNeededTooMany {
            errorText =  "Too many steps to take.\n\nMaximum steps: \(Goal.neededStepUnitsMaximum)."
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
        if baseData.stepUnit == nil { throw GoalError.stepUnitEmpty }
        if baseData.stepUnit == .custom && baseData.customUnit.isEmpty { throw GoalError.stepCustomUnitEmpty }
        
        if baseData.neededStepUnits! < Goal.neededStepUnitsMinimum
            && baseData.stepUnit != .km
            && baseData.stepUnit != .miles
            && baseData.stepUnit != .hours {
            throw GoalError.stepsNeededTooLittle
        }
        if baseData.neededStepUnits! > Goal.neededStepUnitsMaximum {
            throw GoalError.stepsNeededTooMany
        }
    }
}
