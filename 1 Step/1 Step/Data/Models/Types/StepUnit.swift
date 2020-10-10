//
//  GoalStepsUnit.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import Foundation

@objc
enum StepUnit: Int16 {
    
    //Duration
    case hours      = 0
    case min        = 1
    
    //Distance
    case km         = 2
    case m          = 3
    case miles      = 4
    case yards      = 5
    case feets      = 6
    
    //Reps
    case times      = 7
    case pages      = 8
    case steps      = 9
    case decisions  = 10
    case mountains  = 11
    case books      = 12
    
    case custom     = 13
}
