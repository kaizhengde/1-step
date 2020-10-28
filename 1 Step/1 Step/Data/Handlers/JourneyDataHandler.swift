//
//  MilestonesHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

enum JourneyDataHandler {
    
    /*
     ALGORITHM
     
     Invariant:         Prev <= Next, 1 or 10 <= NeededStepsUnit <= NeededSteps <= 1000
     Ratio:             [Step:StepUnit] Reps: 1:1, Duration & Distance: 1:n with n is natural number >= 1
     Milestones max:    13
     Preference:        300 - 600 Steps range
     
     Expls:
     70h [duration]
     -> 4200min
     -> 700 Steps with ratio: 1:6

     3km [distance]
     -> 3000m
     -> 500 Steps with ratio: 1:6
     
     123km [distance]
     -> 123 Steps with ratio 1:1
     
     60trees [reps]
     -> 60 Steps with ratio 1:1
     */
    
    
    static func calculateRatio(from baseData: Goal.BaseData) -> Int16 {
        return baseData.stepUnit!.getRatio(from: baseData.neededStepUnits!)
    }
    
    
    static func calculateStepAddArrays(from baseData: Goal.BaseData) -> (unit: [String], dual: [String]) {
        return baseData.stepUnit!.getStepAddArrays(from: baseData.neededStepUnits!)
    }
    

    //ALGO: O(1) From goal.neededStepUnits & goal.step.ratio -> goal.milestones
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
                
                print("---------------------------")
                print("Title: \(milestone.neededStepUnits) \(goal.step.unit)")
                print("Steps: \(milestone.neededSteps)")
                print("Ratio: \(goal.step.unitRatio)")
                
                milestones.insert(milestone)
            }
        }
        
        
        //5. Add the summit milestone
        
        let summitMilestone = Milestone(context: PersistenceManager.defaults.context)
        
        summitMilestone.neededStepUnits   = Double(goal.neededStepUnits)
        summitMilestone.neededSteps       = goal.neededStepUnits * goal.step.unitRatio
        summitMilestone.state             = .active
        summitMilestone.endDate           = nil
        summitMilestone.parentGoal        = goal
        
        milestones.insert(summitMilestone)
        
        print("-----------Summit-----------")
        print("Title: \(summitMilestone.neededStepUnits) \(goal.step.unit)")
        print("Steps: \(summitMilestone.neededSteps)")
        print("Ratio: \(goal.step.unitRatio)")
        
        
        //6. Return
        
        return milestones
    }
}
