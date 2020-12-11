//
//  GoalJourneyDataHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import SwiftUI

enum GoalJourneyDataHandler {
    
    static func addStepsAndUpdateData(with goal: Goal, newStepUnits: Double) {
                
        //0. Calculate new currentStepUnits - make sure it's rounded and not more than (total)neededStepUnits
        
        let newCurrentStepUnits = calculateNewCurrentStepUnits(with: goal, newStepUnits: newStepUnits)
                    
        
        //1. Update Currents
        
        goal.currentStepUnits   = newCurrentStepUnits
        goal.currentSteps       = Int16(goal.currentStepUnits*Double(goal.step.unitRatio))
        goal.currentPercent     = Int16((goal.currentStepUnits/Double(goal.neededStepUnits)).oneSRounded()*100)
        goal.currentState       = Int16(goal.currentStepUnits) >= goal.neededStepUnits ? .reached : .active
        
        
        //2. Update Milestones
        
        let milestones = goal.sortedMilestones
        
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
            }
        }
            
        goal.milestones = Set(milestones)

        
        //3. Update StepEntries (only if no edit) and Milestone endDate accordingly
        
        if newStepUnits < 0 {
            let entriesToBeDeleted = goal.addEntries.filter { newCurrentStepUnits < $0.neededStepUnits }
            
            for entry in entriesToBeDeleted {
                goal.addEntries.remove(entry)
                PersistenceManager.defaults.context.delete(entry)
            }
        }
        if newStepUnits != 0 && !goal.addEntries.contains(where: { $0.neededStepUnits == newCurrentStepUnits }) && newCurrentStepUnits > 0 {
            let newAddEntry = AddEntry(context: PersistenceManager.defaults.context)
            
            newAddEntry.newStepUnits    = newStepUnits
            newAddEntry.newSteps        = Int16(newStepUnits*Double(goal.step.unitRatio))
            newAddEntry.neededStepUnits = newCurrentStepUnits
            newAddEntry.date            = Date()
            
            goal.addEntries.insert(newAddEntry)
        }
        
        
        for milestone in goal.milestones {
            if milestone.state == .done && milestone.endDate == nil {
                let matchingStepEntry = goal.addEntries
                    .filter { milestone.neededStepUnits <= $0.neededStepUnits }
                    .sorted { $0.neededStepUnits < $1.neededStepUnits }
                    .first!
                
                milestone.endDate = matchingStepEntry.date
                
            } else if milestone.endDate != nil {
                if newCurrentStepUnits < milestone.neededStepUnits {
                    milestone.endDate = nil
                }
            }
        }
        
        print(goal.addEntries.map { $0.neededStepUnits }.sorted())
    }
    
    
    static func calculateNewCurrentStepUnits(with goal: Goal, newStepUnits: Double) -> Double {
        var newCurrentStepUnits = goal.currentStepUnits + newStepUnits
        
        if abs(newCurrentStepUnits - newCurrentStepUnits.oneSRounded()) < Double.almostZero {
            newCurrentStepUnits.oneSRound()
        }
        
        if newCurrentStepUnits > Double(goal.neededStepUnits) {
            newCurrentStepUnits = Double(goal.neededStepUnits)
        }
        
        return newCurrentStepUnits
    }
}
