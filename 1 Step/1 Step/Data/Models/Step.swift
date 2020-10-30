//
//  Step.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

final class Step: NSManagedObject {
    
    @NSManaged var unit: StepUnit
    @NSManaged var customUnit: String
    
    @NSManaged var unitRatio: Int16
    @NSManaged var addArray: [String]
    @NSManaged var addArrayDual: [String]
    
    @NSManaged var goal: Goal
}

extension Step {
    
    static let customUnitDigitsLimit = 10
    
    var addArrayLastIndex: Int { addArray.count-1 }
    var addArrayDualLastIndex: Int { addArrayDual.count-1 }
    
    var oneAddArrayEmpty: Bool { addArray.isEmpty || addArrayDual.isEmpty }
}
