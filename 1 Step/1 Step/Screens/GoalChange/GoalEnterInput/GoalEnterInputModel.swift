//
//  GoalEnterInputModel.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI
import Combine

struct GoalEnterInputData {
    
    var goalName: String                = ""
    var neededStepUnits: String         = ""
    var stepCategory: StepCategory?     = nil
    var stepUnit: StepUnit?             = nil
    var customUnit: String              = ""
}


protocol GoalEnterInputDelegate: AnyObject {
    
    //Somewhere to put the selectedEnterInputData
    var selectedEnterInputData: GoalEnterInputData { get set }
}

final class GoalEnterInputModel: ObservableObject {
    
    @Published var selectedData = GoalEnterInputData() {
        didSet { delegate?.selectedEnterInputData = selectedData }
    }
    
    weak var delegate: GoalEnterInputDelegate?
    
    //MARK: - GoalEnterInputSelectStepUnit
    
    //Button
    
    func stepEnterUnitButtonText() -> String {
        guard let stepUnit = selectedData.stepUnit else { return Localized.Step.unit_times }

        if stepUnit == .custom {
            return selectedData.customUnit.isEmpty ? Localized.Step.unit_custom : selectedData.customUnit
        }
        
        return stepUnit.description
    }
    
    
    func stepEnterUnitButtonColor(_ selectedColor: UserColor) -> Color {
        guard let stepUnit = selectedData.stepUnit else { return .lightNeutralToLightGray }
        return stepUnit.description.isEmpty ? .lightNeutralToLightGray : selectedColor.standard
    }

    
    //StepCategory
    
    func stepCategoryButtonColor(_ stepCategory: StepCategory, _ selectedColor: UserColor) -> Color {
        return selectedData.stepCategory == stepCategory ? .backgroundToGray : selectedColor.dark
    }
    
    
    func stepCategoryButtonTextColor(_ stepCategory: StepCategory) -> Color {
        return selectedData.stepCategory == stepCategory ? .grayToBackground : .backgroundToGray
    }
    
    
    //StepUnit
    
    func stepUnitButtonColor(_ stepUnit: StepUnit, _ selectedColor: UserColor) -> Color {
        return selectedData.stepUnit == stepUnit ? .backgroundToGray : selectedColor.dark
    }
    
    
    func stepUnitButtonTextColor(_ stepUnit: StepUnit) -> Color {
        return selectedData.stepUnit == stepUnit ? .grayToBackground : .backgroundToGray
    }
}
