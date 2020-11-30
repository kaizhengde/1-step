//
//  GoalJourneyDataHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import SwiftUI

enum GoalJourneyDataHandler {
    
    static func addStepsAndUpdate(with goal: Goal, newStepUnits: Double) -> Goal.JourneyData {
        
        var journeyData: Goal.JourneyData = (0, 0, 0, .active, [] ,[])
        
        
        //0. Calculate new currentStepUnits - make sure it's rounded and not more than (total)neededStepUnits
        
        var newCurrentStepUnits = goal.currentStepUnits + newStepUnits
        
        if abs(newCurrentStepUnits - newCurrentStepUnits.oneSRounded()) < Double.almostZero {
            newCurrentStepUnits.oneSRound()
        }
                
        if newCurrentStepUnits > Double(goal.neededStepUnits) {
            newCurrentStepUnits = Double(goal.neededStepUnits)
        }
        
        
        //1. Update Currents
        
        journeyData.currentStepUnits    = newCurrentStepUnits
        journeyData.currentSteps        = Int16(journeyData.currentStepUnits*Double(goal.step.unitRatio))
        journeyData.currentPercent      = Int16((journeyData.currentStepUnits/Double(goal.neededStepUnits))*100)
        journeyData.currentState        = Int16(journeyData.currentStepUnits) >= goal.neededStepUnits ? .reached : .active
        
        
        //2. Update StepsDate
        
        journeyData.stepsDate           = Array<Date>(repeating: .distantFuture, count: Int(goal.neededSteps))
        
        for i in 0..<Int(journeyData.currentSteps) {
            if i < goal.stepsDate.filter({ $0 != .distantFuture }).count {
                journeyData.stepsDate[i] = goal.stepsDate[i]
            } else {
                journeyData.stepsDate[i] = Date()
            }
        }
        
        
        //3. Update Milestones
        
        let milestones = Array(goal.milestones.sorted { $0.neededStepUnits < $1.neededStepUnits })
        
        for i in 0..<milestones.count {

            let milestone = milestones[i]
            let prevMilestone: Milestone? = i == 0 ? nil : milestones[i-1]
            let currentStepUnits = journeyData.currentStepUnits

            if currentStepUnits < prevMilestone?.neededStepUnits ?? 0 {
                milestones[i].state = .active
            }
            if currentStepUnits < milestone.neededStepUnits && currentStepUnits >= prevMilestone?.neededStepUnits ?? 0 {
                milestones[i].state = .current
            }
            if currentStepUnits >= milestone.neededStepUnits {
                milestones[i].state = .done
                milestones[i].endDate = journeyData.stepsDate[Int(milestones[i].neededSteps)-1]
            }
        }
        
        journeyData.milestones = Set(milestones)
        

        print("-------------")
        print("Goal:        \(goal.name)")
        print("StepUnits:   \(journeyData.currentStepUnits)")
        print("Steps:       \(journeyData.currentSteps)")
        print("Percent:     \(journeyData.currentPercent)")
        print("State:       \(journeyData.currentState.rawValue)")
        print("StepsDate:   \(journeyData.stepsDate.filter({ $0 != .distantFuture }))")
        print("Milestones:  \(journeyData.milestones.map { "Needed Units: \($0.neededStepUnits), State: \($0.state.rawValue)" })")
        print("-------------")
        
        return journeyData
    }
}
