//
//  GoalNotification.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import CoreData

final class GoalNotification: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var sortOrder: Int16
    
    @NSManaged var time: Date
    @NSManaged var weekdays: [Int16]
    
    @NSManaged var parentGoal: Goal
}

