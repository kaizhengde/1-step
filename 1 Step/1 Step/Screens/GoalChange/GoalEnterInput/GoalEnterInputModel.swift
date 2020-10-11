//
//  GoalEnterInputModel.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI
import Combine

struct GoalEnterInputData {
    
    var goalName: String            = ""
    var stepsNeeded: String         = ""
    var stepCategory: StepCategory? = nil
    var stepUnit: StepUnit?         = nil
    var stepCustomUnit: String      = ""
}


protocol GoalEnterInputDelegate: AnyObject {
    
    //Somewhere to put the selectedEnterInputData
    var selectedEnterInputData: GoalEnterInputData { get set }
}

final class GoalEnterInputModel: ObservableObject {
    
    @Published var selectedData = GoalEnterInputData()
    
    weak var delegate: GoalEnterInputDelegate?
    
    
    //MARK: - GoalEnterInputSelectStepUnit
    
    //Button
    
    func stepEnterUnitButtonText() -> String {
        guard let stepUnit = selectedData.stepUnit else { return "times" }
        
        if stepUnit == .custom {
            return selectedData.stepCustomUnit.isEmpty ? "custom" : selectedData.stepCustomUnit
        }
        return stepUnit.description
    }
    
    
    func stepEnterUnitButtonColor(_ selectedColor: UserColor) -> Color {
        return selectedData.stepUnit == nil ? .lightNeutralToLightGray : selectedColor.get()
    }

    
    //StepCategory
    
    func stepCategoryButtonColor(_ stepCategory: StepCategory) -> Color {
        return selectedData.stepCategory == stepCategory ? .backgroundToGray : .opacityBackgroundDarker
    }
    
    
    func stepCategoryButtonTextColor(_ stepCategory: StepCategory) -> Color {
        return selectedData.stepCategory == stepCategory ? .grayToBackground : .backgroundToGray
    }
    
    
    //StepUnit
    
    func stepUnitButtonColor(_ stepUnit: StepUnit) -> Color {
        return selectedData.stepUnit == stepUnit ? .backgroundToGray : .opacityBackgroundDarker
    }
    
    
    func stepUnitButtonTextColor(_ stepUnit: StepUnit) -> Color {
        return selectedData.stepUnit == stepUnit ? .grayToBackground : .backgroundToGray
    }
}
