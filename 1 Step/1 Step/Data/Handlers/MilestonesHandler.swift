//
//  MilestonesHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

enum MilestonesHandler {
    
    /*
     Es wird entfernt, wenn der Abstand geringer wäre zum letzten, als zu einem vorherigen.
     Die Invariante: Next immer größer gleich Prev
     
     10 | 25 | 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 1000
     */
    
    static func generateNewMilestones(with goal: Goal) -> Set<Milestone> {
        
        return []
    }
}
