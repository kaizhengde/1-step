//
//  MilestonesHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

enum MilestonesHandler {
    
    /*
     
     **10**
     5
     10
     
     **100**
     5
     10
     25
     50
     100
     
     **1000**
     5
     10
     25
     50
     100
     200
     300
     400
     500
     600
     700
     800
     900
     1000
     
     -----------
     
     **812**
     5
     10
     25
     50
     100
     200
     300
     400
     500
     600
     700
     812
     
     **602**
     5
     10
     25
     50
     100
     200
     300
     400
     500
     602
     
     **790**
     5
     10
     25
     50
     100
     200
     300
     400
     500
     600
     790
     
     **990**
     5
     10
     25
     50
     100
     200
     300
     400
     500
     600
     700
     800
     990
     
     Es wird entfernt, wenn der Abstand geringer wäre zum letzten, als zu einem vorherigen.
     Die Invariante: Next immer größer gleich Prev
     
     Sonst sind die Elementarschritte:
     
     5
     10
     25
     50
     100
     200
     300
     400
     500
     600
     700
     800
     900
     1000
     
     = 14 Milestones
     = 14 Symbole...
     
     
     
     */
    
    static func generateNewMilestones(with goal: Goal) -> Set<Milestone> {
        
        return []
    }
}
