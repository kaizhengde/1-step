//
//  Goal.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI
import CoreData

class Goal: NSManagedObject, Identifiable {
    
    //Consecutive from 0..<#activeGoals -> deletion, reached - update all orders respectively
    //For reachedGoals: -1
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
    
    typealias ChangeData = (
        name:           String,
        stepCategory:   StepCategory?,
        stepUnit:       StepUnit?,
        stepCustomUnit: String,
        stepsNeeded:    Int16?,
        mountain:       MountainImage?,
        color:          UserColor?
    )
    
    static let nameDigitsLimit = 15
    static let stepsNeededDigitsLimit = 4
    
    static let stepsNeededMinimum: Int16 = 10
    static let stepsNeededMaximum: Int16 = 1000
}
