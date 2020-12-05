//
//  StepHistory.swift
//  1 Step
//
//  Created by Kai Zheng on 05.12.20.
//

import SwiftUI
import CoreData

final class AddEntry: NSManagedObject {
    
    @NSManaged var newStepUnits: Double
    @NSManaged var newSteps: Int16
    
    @NSManaged var neededStepUnits: Double
    @NSManaged var date: Date
}
