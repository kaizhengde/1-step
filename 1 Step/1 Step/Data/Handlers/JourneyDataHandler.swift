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
     Max:               10 | 25 | 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 1000
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
    
    
    //From goal.neededStepUnits -> goal.step.unit
    static func calculateRatio(from baseData: Goal.BaseData) -> Int16 {
        switch baseData.stepCategory! {
        case .duration: return calculateRatioDuration(baseData)
        case .distance: return calculateRatioDistance(baseData)
        case .reps:     return 1
        }
    }
    

    static func calculateRatioDuration(_ baseData: Goal.BaseData) -> Int16 {

        //If minutes just return
        guard baseData.stepUnit == StepUnit.hours.description else { return 1 }
        
        
        switch baseData.neededStepUnits! {
        case 400...1000:    return 1    //Steps: [400 -> 1000]      1 Step = 1 Hour
        case 200...399:     return 2    //Steps: [400 -> 798]       1 Step = 30 Minutes
        case 90...199:      return 3    //Steps: [270 -> 597]       1 Step = 20 Minutes
        case 60...89:       return 4    //Steps: [240 -> 356]       1 Step = 15 Minutes
        case 30...59:       return 6    //Steps: [180 -> 354]       1 Step = 10 Minutes
        case 15...29:       return 10   //Steps: [150 -> 297]       1 Step = 6 Minutes
        case 8...14:        return 20   //Steps: [160 -> 280]       1 Step = 3 Minutes
        case 4...7:         return 30   //Steps: [120 -> 210]       1 Step = 2 Minutes
        case 1...3:         return 60   //Steps: [60 -> 180]        1 Step = 1 Minute
        default: break
        }
        
        return 0
    }
    
    
    static func calculateRatioDistance(_ baseData: Goal.BaseData) -> Int16 {
        
        //Check if kilometer/meter or miles/feet
        if baseData.stepUnit == StepUnit.km.description || baseData.stepUnit == StepUnit.m.description {
            
            //If meters, just return
            guard baseData.stepUnit == StepUnit.km.description else { return 1 }
            
            switch baseData.neededStepUnits! {
            case 400...1000:    return 1    //Steps: [400 -> 1000]      1 Step = 1 Kilometer
            case 200...399:     return 2    //Steps: [400 -> 798]       1 Step = 500 Meters
            case 100...199:     return 4    //Steps: [400 -> 796]       1 Step = 250 Meters
            case 40...99:       return 5    //Steps: [200 -> 495]       1 Step = 200 Meters
            case 20...39:       return 10   //Steps: [200 -> 390]       1 Step = 100 Meters
            case 8...19:        return 20   //Steps: [160 -> 380]       1 Step = 50 Meters
            case 4...7:         return 50   //Steps: [200 -> 350]       1 Step = 20 Meters
            case 1...3:         return 100  //Steps: [100 -> 300]       1 Step = 10 Meters
            default: break
            }
        } else {
            
            //If feets, just return
            guard baseData.stepUnit == StepUnit.miles.description else { return 1 }
            
            switch baseData.neededStepUnits! {
            case 400...1000:    return 1    //Steps: [400 -> 1000]      1 Step = 1 Mile
            case 200...399:     return 2    //Steps: [400 -> 798]       1 Step = 0.5 Mile
            case 100...199:     return 4    //Steps: [400 -> 796]       1 Step = 0.25 Mile
            case 40...99:       return 5    //Steps: [200 -> 495]       1 Step = 0.2 Mile
            case 20...39:       return 10   //Steps: [200 -> 390]       1 Step = 0.1 Mile
            case 8...19:        return 20   //Steps: [160 -> 380]       1 Step = 0.05 Mile
            case 4...7:         return 50   //Steps: [200 -> 350]       1 Step = 0.02 Mile
            case 1...3:         return 100  //Steps: [100 -> 300]       1 Step = 0.01 Mile
            default: break
            }
        }
        
        return 0
    }
    

    //ALGO: O(1) From goal.neededStepUnits & goal.step.ratio -> goal.milestones
    static func generateMilestones(with goal: Goal) -> Set<Milestone> {
        
        let neededStepUnits = goal.neededStepUnits
        let milestoneSteps: MilestoneStage.MilestoneSteps = neededStepUnits < 10 ? .small : .big
        
        //1. Find lower bound [690 -> 600]
        
        var lowerBoundNeeded: Int16 = 0
        var lowerBound: MilestoneStage = .none

        for milestoneStage in MilestoneStage.allCases {
            if milestoneStage.neededStepUnits(milestoneSteps) <= neededStepUnits {
                lowerBoundNeeded = max(milestoneStage.neededStepUnits(milestoneSteps), lowerBoundNeeded)
                lowerBound = MilestoneStage.stageFrom(neededStepUnits: lowerBoundNeeded, milestoneSteps)
            }
        }
        
        
        //2. Calculate differences [85 - 50 -> 35], [50 - 25 -> 25]
        
        let differenceNeededLower = neededStepUnits - lowerBound.neededStepUnits(milestoneSteps)
        let differenceLowerPrev   = lowerBound.neededStepUnits(milestoneSteps) - lowerBound.infos.prev.neededStepUnits(milestoneSteps)
        
        
        //3. Determine last milestone before summit (Invariant!)
        
        var lastMilestoneStage: MilestoneStage = .none
        
        if differenceNeededLower >= differenceLowerPrev {
            lastMilestoneStage = lowerBound
        } else {
            lastMilestoneStage = lowerBound.infos.prev
        }
        
        
        //4. Generate milestones until the last milestone
        
        var milestones: Set<Milestone> = []
        
        for milestoneStage in MilestoneStage.allCases {
            if milestoneStage.neededStepUnits(milestoneSteps) <= lastMilestoneStage.neededStepUnits(milestoneSteps) && milestoneStage != .none {
                let milestone = Milestone(context: PersistenceManager.defaults.context)
                
                milestone.stage             = milestoneStage
                milestone.neededSteps       = milestoneStage.neededStepUnits(milestoneSteps) * goal.step.unitRatio
                milestone.state             = .active
                milestone.endDate           = nil
                milestone.parentGoal        = goal
                
                print("---------------------------")
                print("Title: \(milestone.stage.neededStepUnits(milestoneSteps)) \(goal.step.unit)")
                print("Steps: \(milestone.neededSteps)")
                
                milestones.insert(milestone)
            }
        }
        
        
        //5. Add the summit milestone
        
        let summitMilestone = Milestone(context: PersistenceManager.defaults.context)
        
        summitMilestone.stage             = MilestoneStage.summit
        summitMilestone.neededStepUnits   = neededStepUnits
        summitMilestone.neededSteps       = neededStepUnits * goal.step.unitRatio
        summitMilestone.state             = .active
        summitMilestone.endDate           = nil
        summitMilestone.parentGoal        = goal
        
        milestones.insert(summitMilestone)
        
        print("-----------Summit-----------")
        print("Title: \(summitMilestone.neededStepUnits) \(goal.step.unit)")
        print("Steps: \(summitMilestone.neededSteps)")
        
        
        //6. Return
        
        return milestones
    }
}
