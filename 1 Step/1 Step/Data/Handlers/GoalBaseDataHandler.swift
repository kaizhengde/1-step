//
//  GoalBaseDataHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import SwiftUI

enum GoalBaseDataHandler {
    
    static func setupCalculationBaseData(with goal: Goal, _ step: Step) {
        step.unitRatio      = step.unit.getRatio(from: goal.neededStepUnits)
        goal.neededSteps    = goal.neededStepUnits * step.unitRatio
        
        let addArrays       = step.unit.getStepAddArrays(from: goal.neededStepUnits)
        step.addArray       = addArrays.unit
        step.addArrayDual   = addArrays.dual
        
        goal.milestones     = generateMilestones(with: goal)
        
        FirebaseAnalyticsEvent.Goal.milestonesCount(goal.milestones.count)
    }
    
    
    /*
     ------------ ALGORITHM: generateMilestones(with:) ------------
     Invariant:         Prev <= Next, 1 or 10 <= NeededStepsUnit <= NeededSteps <= 1000
     Ratio:             [Step:StepUnit] Reps: 1:1, Duration & Distance: 1:n with n is natural number >= 1
     Milestones max:    9
     Preference:        300 - 600 Steps range
     */
    
    static func generateMilestones(with goal: Goal) -> Set<Milestone> {
        
        let milestoneStages = MilestoneStages(maxNeededStepUnits: MilestoneStages.getMaxNeededStepUnits(from: goal.neededStepUnits))
        
        
        //1. Find lower bound [690 -> 600]
        
        var lowerBound: Double = 0
        var lowerBoundPrev: Double = 0

        for i in 0..<milestoneStages.neededStepUnits.count {
            if milestoneStages.neededStepUnits[i] <= Double(goal.neededStepUnits) {
                lowerBound = max(milestoneStages.neededStepUnits[i], lowerBound)
                lowerBoundPrev = milestoneStages.neededStepUnits[i-1 >= 0 ? i-1 : 0]
            }
        }
        
        
        //2. Calculate differences [85 - 50 -> 35], [50 - 25 -> 25]
        
        let differenceNeededLower = Double(goal.neededStepUnits) - lowerBound
        let differenceLowerPrev   = lowerBound - lowerBoundPrev
        
        
        //3. Determine last milestone before summit (Invariant!)
        
        var lastStageNeededStepUnits: Double = 0
        
        if differenceNeededLower >= differenceLowerPrev {
            lastStageNeededStepUnits = lowerBound
        } else {
            lastStageNeededStepUnits = lowerBoundPrev
        }
        
        
        //4. Generate milestones until the last milestone
        
        var milestones: Set<Milestone> = []
        
        for stageNeededStepUnits in milestoneStages.neededStepUnits {
            if stageNeededStepUnits <= lastStageNeededStepUnits {
                let milestone = Milestone(context: PersistenceManager.defaults.context)
                
                milestone.neededStepUnits   = stageNeededStepUnits
                milestone.neededSteps       = Int16(stageNeededStepUnits * Double(goal.step.unitRatio))
                milestone.state             = .active
                milestone.endDate           = nil
                milestone.parentGoal        = goal
                
                milestones.insert(milestone)
            }
        }
        
        
        //5. Add the summit milestone
        
        let summitMilestone = Milestone(context: PersistenceManager.defaults.context)
        
        summitMilestone.neededStepUnits = Double(goal.neededStepUnits)
        summitMilestone.neededSteps     = goal.neededStepUnits * goal.step.unitRatio
        summitMilestone.state           = .active
        summitMilestone.endDate         = nil
        summitMilestone.image           = .summit
        summitMilestone.parentGoal      = goal
        
        milestones.insert(summitMilestone)

        
        //6. Assign images and stepsFromPrev to all milestones
        
        let milestonesArray = Array(milestones.sorted { $0.neededStepUnits < $1.neededStepUnits })
        
        for i in 0..<milestonesArray.count {
            let prevMilestone: Milestone? = i == 0 ? nil : milestonesArray[i-1]
            let milestone = milestonesArray[i]
                        
            milestonesArray[i].stepUnitsFromPrev = milestone.neededStepUnits - (prevMilestone?.neededStepUnits ?? 0)
            milestonesArray[i].stepsFromPrev = milestone.neededSteps - (prevMilestone?.neededSteps ?? 0)
            
            milestonesArray[i].image = MilestoneImage(rawValue: Int16(i))!
        }
        
        
        //6.1 Correct starting milestone and summit milestone
        
        milestonesArray[0].state = .current
        milestonesArray[milestonesArray.count-1].image = .summit
        
        milestones = Set(milestonesArray)
        
        
        //7. Return
        
        return milestones
    }
}
