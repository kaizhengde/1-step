//
//  GoalJourneyDataHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import SwiftUI

enum GoalJourneyDataHandler {
    
    static func addStepsAndUpdateData(with goal: Goal, newStepUnits: Double, completion: @escaping () -> ()) {
                
        //0. Calculate new currentStepUnits - make sure it's rounded and not more than (total)neededStepUnits
        
        var newCurrentStepUnits = goal.currentStepUnits + newStepUnits
        
        if abs(newCurrentStepUnits - newCurrentStepUnits.oneSRounded()) < Double.almostZero {
            newCurrentStepUnits.oneSRound()
        }
                
        if newCurrentStepUnits > Double(goal.neededStepUnits) {
            newCurrentStepUnits = Double(goal.neededStepUnits)
        }
        
        
        //1. Update Currents
        
        goal.currentStepUnits   = newCurrentStepUnits
        goal.currentSteps       = Int16(goal.currentStepUnits*Double(goal.step.unitRatio))
        goal.currentPercent     = Int16((goal.currentStepUnits/Double(goal.neededStepUnits))*100)
        goal.currentState       = Int16(goal.currentStepUnits) >= goal.neededStepUnits ? .reached : .active
        
        
        //2. Update Milestones
        
        let milestones = Array(goal.milestones.sorted { $0.neededStepUnits < $1.neededStepUnits })
        
        for i in 0..<milestones.count {

            let milestone = milestones[i]
            let prevMilestone: Milestone? = i == 0 ? nil : milestones[i-1]
            let currentStepUnits = goal.currentStepUnits

            if currentStepUnits < prevMilestone?.neededStepUnits ?? 0 {
                milestone.state = .active
            }
            if currentStepUnits < milestone.neededStepUnits && currentStepUnits >= prevMilestone?.neededStepUnits ?? 0 {
                milestone.state = .current
            }
            if currentStepUnits >= milestone.neededStepUnits {
                milestone.state = .done
                milestone.endDate = .distantFuture
            }
        }
            
        goal.milestones = Set(milestones)

        
        //3. Update StepsDate
        
        var stepsDate = Array<Date>(repeating: .distantFuture, count: Int(goal.neededSteps))
        
        DispatchQueue.global().async {
            for i in 0..<Int(goal.currentSteps) {
                if i < goal.stepsDate.filter({ $0 != .distantFuture }).count {
                    stepsDate[i] = goal.stepsDate[i]
                } else {
                    stepsDate[i] = Date()
                }
            }
            
            DispatchQueue.main.async {
                goal.stepsDate = stepsDate
                
                for milestone in goal.milestones {
                    if milestone.state == .done {
                        milestone.endDate = goal.stepsDate[Int(milestone.neededSteps)-1]
                    }
                }
                
                completion()
            }
            
            
            print("-------------")
            print("Goal:        \(goal.name)")
            print("StepUnits:   \(goal.currentStepUnits)")
            print("Steps:       \(goal.currentSteps)")
            print("Percent:     \(goal.currentPercent)")
            print("State:       \(goal.currentState.rawValue)")
            print("StepsDate:   \(goal.stepsDate.filter({ $0 != .distantFuture }))")
            print("Milestones:  \(goal.milestones.map { "Needed Units: \($0.neededStepUnits), State: \($0.state.rawValue)" })")
            print("-------------")
        }
    }
}
