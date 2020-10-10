//
//  Step.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

class Step: NSManagedObject {
    
    @NSManaged var category: StepCategory
    @NSManaged var unit: StepUnit
    @NSManaged var customUnit: String
    
    @NSManaged var goal: Goal
}

extension Step {
    
    static let customUnitDigitsLimit = 10
}
