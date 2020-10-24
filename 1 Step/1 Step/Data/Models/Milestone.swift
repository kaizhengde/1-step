//
//  Milestone.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

final class Milestone: NSManagedObject {
    
    @NSManaged var stage: MilestoneStage
    
    @NSManaged var neededStepUnits: Int16
    @NSManaged var neededSteps: Int16
    @NSManaged var state: MilestoneState
    @NSManaged var endDate: Date?
    
    @NSManaged var parentGoal: Goal
}

