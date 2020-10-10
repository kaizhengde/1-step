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
}
