//
//  Goal.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

class Goal: NSManagedObject, Identifiable {
    
    @NSManaged var sortOrder: Int16
    
    @NSManaged var name: String
    
    @NSManaged var step: Step
    @NSManaged var stepsNeeded: Int16
    
    @NSManaged var currentSteps: Int16
    @NSManaged var currentPercent: Int16
    @NSManaged var currentState: GoalState

    @NSManaged var startDate: Date
    @NSManaged var endDate: Date?
    @NSManaged var mountain: MountainImage
    @NSManaged var color: UserColor
    
    @NSManaged var milestones: Set<Milestone>
}

extension Goal {
    
    static let nameDigitsLimit = 20
    static let stepsNeededDigitsLimit = 4
    
    static let stepsNeededMinimum = 10
    static let stepsNeededMaximum = 10000
}
