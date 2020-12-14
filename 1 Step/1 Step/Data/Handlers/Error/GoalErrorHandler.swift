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
            errorText = Localized.GoalError.goalNameEmpty
        }
        catch GoalError.stepsNeededEmpty {
            errorText = Localized.GoalError.stepsNeededEmpty
        }
        catch GoalError.stepUnitEmpty {
            errorText = Localized.GoalError.stepUnitEmpty
        }
        catch GoalError.stepCustomUnitEmpty {
            errorText = Localized.GoalError.stepCustomUnitEmpty
        }
        catch GoalError.stepsNeededTooLittle {
            errorText = "\(Localized.GoalError.stepsNeededTooLittle) \(Goal.neededStepUnitsMinimum)."
        }
        catch GoalError.stepsNeededTooMany {
            errorText = "\(Localized.GoalError.stepsNeededTooMany) \(Goal.neededStepUnitsMaximum)."
        }
        catch {
            errorText = Localized.GoalError.unknown
        }
        
        PopupManager.shared.showPopup(backgroundColor: baseData.color!.standard, hapticFeedback: true) {
            OneSTextPopupView(titleText: Localized.ohDeer, titleImage: Symbol.deer, bodyText: errorText)
        }
        
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
            errorText = Localized.GoalError.currentBelowNeededStepUnits
        }
        catch let GoalEditError.changeOfCategory(from: fromCategory, to: toCategory) {
            errorText = "\(Localized.GoalError.changeOfCategory)\n\(fromCategory.description) -> \(toCategory.description)"
        }
        catch GoalEditError.changeOfDistanceUnitsSystem {
            errorText = Localized.GoalError.changeOfDistanceUnitsSystem
        }
        catch {
            errorText = Localized.GoalError.unknown
        }
        
        PopupManager.shared.showPopup(backgroundColor: goal.color.standard, hapticFeedback: true) {
            OneSTextPopupView(titleText: Localized.ohDeer, titleImage: Symbol.deer, bodyText: errorText)
        }
        
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
