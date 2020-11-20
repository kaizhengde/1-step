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
        guard let stepUnit = selectedData.stepUnit else { return "trees" }

        if stepUnit == .custom {
            return selectedData.customUnit.isEmpty ? "custom" : selectedData.customUnit
        }
        
        return stepUnit.description
    }
    
    
    func stepEnterUnitButtonColor(_ selectedColor: UserColor) -> Color {
        guard let stepUnit = selectedData.stepUnit else { return .lightNeutralToLightGray }
        return stepUnit.description.isEmpty ? .lightNeutralToLightGray : selectedColor.get()
    }

    
    //StepCategory
    
    func stepCategoryButtonColor(_ stepCategory: StepCategory, _ selectedColor: UserColor) -> Color {
        return selectedData.stepCategory == stepCategory ? .backgroundToGray : selectedColor.get(.dark)
    }
    
    
    func stepCategoryButtonTextColor(_ stepCategory: StepCategory) -> Color {
        return selectedData.stepCategory == stepCategory ? .grayToBackground : .backgroundToGray
    }
    
    
    //StepUnit
    
    func stepUnitButtonColor(_ stepUnit: StepUnit, _ selectedColor: UserColor) -> Color {
        return selectedData.stepUnit == stepUnit ? .backgroundToGray : selectedColor.get(.dark)
    }
    
    
    func stepUnitButtonTextColor(_ stepUnit: StepUnit) -> Color {
        return selectedData.stepUnit == stepUnit ? .grayToBackground : .backgroundToGray
    }
}
