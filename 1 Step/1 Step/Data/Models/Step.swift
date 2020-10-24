//
//  Step.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

final class Step: NSManagedObject {
    
    @NSManaged var category: StepCategory
    @NSManaged var unit: String
    @NSManaged var unitRatio: Int16
    
    @NSManaged var goal: Goal
}

extension Step {
    
    static let customUnitDigitsLimit = 10
}
