//
//  DataModel.swift
//  1 Step
//
//  Created by Kai Zheng on 11.10.20.
//

import SwiftUI

final class DataModel: ObservableObject {
    
    static let shared = DataModel()
    private init() {}
    
    private let dataManager = DataManager.defaults
    
    
    //Insert
    
    func createGoal(with changeData: Goal.ChangeData) -> Bool {
        guard !GoalErrorHandler.hasErrors(with: changeData) else { return false }
        
        dataManager.insertGoal(with: changeData)
        return true
    }
}
