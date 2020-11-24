//
//  GoalErrorHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import Foundation

enum GoalErrorHandler {
    
    
    //MARK: - GoalCreate/Edit EnterInput
    
    enum GoalError: Error {
        case goalNameEmpty
        
        case stepsNeededEmpty
        case stepsNeededTooLittle
        case stepsNeededTooMany
        
        case stepUnitEmpty
        case stepCustomUnitEmpty
    }
    
    
    static func hasErrors(with baseData: Goal.BaseData) -> Bool {
        let errorText: String!
        
        do {
            try correctInput(with: baseData)
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
            errorText = "Too little steps to take.\n\nMinimum steps: \(Goal.neededStepUnitsMinimum)."
        }
        catch GoalError.stepsNeededTooMany {
            errorText = "Too many steps to take.\n\nMaximum steps: \(Goal.neededStepUnitsMaximum)."
        }
        catch {
            errorText = "Failed with an unknown error.\n\nConsider restarting the app."
        }
        
        PopupManager.shared.showTextPopup(.none, titleText: "Oh Deer", titleImage: Symbol.deer, bodyText: errorText, backgroundColor: baseData.color!.standard)
        
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
    
    
    //MARK: - GoalEdit
    
    enum GoalEditError: Error {
        
        case currentBelowNeededStepUnits
        case changeOfCategory(from: StepCategory, to: StepCategory)
        case changeOfDistanceUnitsSystem
    }
    
    
    static func editGoalHasErrors(with goal: Goal, baseData: Goal.BaseData) -> Bool {
        let errorText: String!
        
        do {
            try correctEdit(with: goal, baseData: baseData)
            return false
        }
        catch GoalEditError.currentBelowNeededStepUnits {
            errorText = "You can't have a goal with steps to take lower than or equal to your current steps."
        }
        catch let GoalEditError.changeOfCategory(from: fromCategory, to: toCategory) {
            errorText = "You can't change your step category.\n\(fromCategory) -> \(toCategory)\n\nCreate a new goal instead."
        }
        catch GoalEditError.changeOfDistanceUnitsSystem {
            errorText = "You can't change between metric and imperial units.\n\nCreate a new goal instead."
        }
        catch {
            errorText = "Failed with an unknown error.\n\nConsider restarting the app."
        }
        
        PopupManager.shared.showTextPopup(.none, titleText: "Oh Deer", titleImage: Symbol.deer, bodyText: errorText, backgroundColor: goal.color.standard)
        
        return true
    }
    
    
    static func correctEdit(with goal: Goal, baseData: Goal.BaseData) throws {
        if goal.step.unit.category != baseData.stepUnit!.category {
            throw GoalEditError.changeOfCategory(from: goal.step.unit.category, to: baseData.stepUnit!.category)
        }
        
        if goal.step.unit.isMetric && baseData.stepUnit!.isImperial || goal.step.unit.isImperial && baseData.stepUnit!.isMetric {
            throw GoalEditError.changeOfDistanceUnitsSystem
        }
        
        if goal.currentStepUnits >= Double(Double(baseData.neededStepUnits!)*baseData.stepUnit!.translateMultiplier(to: goal.step.unit)) {
            throw GoalEditError.currentBelowNeededStepUnits
        }
    }
}
