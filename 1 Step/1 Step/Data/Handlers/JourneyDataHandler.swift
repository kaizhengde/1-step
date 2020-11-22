//
//  MilestonesHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import SwiftUI

enum JourneyDataHandler {
    
    /*
     Invariant:         Prev <= Next, 1 or 10 <= NeededStepsUnit <= NeededSteps <= 1000
     Ratio:             [Step:StepUnit] Reps: 1:1, Duration & Distance: 1:n with n is natural number >= 1
     Milestones max:    13
     Preference:        300 - 600 Steps range
     */
    
    
    static func calculateRatio(from baseData: Goal.BaseData) -> Int16 {
        return baseData.stepUnit!.getRatio(from: baseData.neededStepUnits!)
    }
    
    
    static func updateStepsDate(with goal: Goal) -> [Date] {
        var newStepsDate = Array<Date>(repeating: .distantFuture, count: Int(goal.neededSteps))
        
        for i in 0..<Int(goal.neededSteps) {
            if i < goal.stepsDate.count {
                newStepsDate[i] = goal.stepsDate[i]
            }
        }
                
        return newStepsDate
    }
    
    
    static func calculateStepAddArrays(from baseData: Goal.BaseData) -> (unit: [String], dual: [String]) {
        return baseData.stepUnit!.getStepAddArrays(from: baseData.neededStepUnits!)
    }
    

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
        
        summitMilestone.neededStepUnits = Double(goal.neededStepUnits)
        summitMilestone.neededSteps     = goal.neededStepUnits * goal.step.unitRatio
        summitMilestone.state           = .active
        summitMilestone.endDate         = nil
        summitMilestone.image           = .summit
        summitMilestone.parentGoal      = goal
        
        milestones.insert(summitMilestone)
        
        print("-----------Summit-----------")
        print("Title: \(summitMilestone.neededStepUnits) \(goal.step.unit)")
        print("Steps: \(summitMilestone.neededSteps)")
        print("Ratio: \(goal.step.unitRatio)")
        
        
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
    
    
    static func addStepsAndUpdate(with goal: Goal, newStepUnits: Double) -> Goal.JourneyData {
        
        var journeyData: Goal.JourneyData = (0, 0, 0, .active, [] ,[])
        
        
        //0. Calculate new CurrentStepUnits
        var newCurrentStepUnits = goal.currentStepUnits + newStepUnits
        
        if abs(newCurrentStepUnits - newCurrentStepUnits.rounded()) < 0.000000001 {
            newCurrentStepUnits.round()
        }
        
        if newCurrentStepUnits > Double(goal.neededStepUnits) {
            newCurrentStepUnits = Double(goal.neededStepUnits)
        }
        
        //1. Update Currents and StepsDate
        
        journeyData.currentStepUnits    = newCurrentStepUnits
        journeyData.currentSteps        = Int16(journeyData.currentStepUnits*Double(goal.step.unitRatio))
        journeyData.currentPercent      = Int16((journeyData.currentStepUnits/Double(goal.neededStepUnits))*100)
        journeyData.currentState        = Int16(journeyData.currentStepUnits) >= goal.neededStepUnits ? .reached : .active
        
        journeyData.stepsDate = Array<Date>(repeating: .distantFuture, count: Int(goal.neededSteps))
        
        for i in 0..<Int(journeyData.currentSteps) {
            if i < goal.stepsDate.filter({ $0 != .distantFuture }).count {
                journeyData.stepsDate[i] = goal.stepsDate[i]
            } else {
                journeyData.stepsDate[i] = Date()
            }
        }
        
        
        //2. Update Milestones
        
        let oldCurrentMilestone = goal.milestones.filter { $0.state == .current }.first!
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
        
        
        //3. Update Accomplishments
        
        let newCurrentMilestone = journeyData.milestones.filter { $0.state == .current }.first
        let milestonesReached = (newCurrentMilestone?.image.rawValue ?? Int16(journeyData.milestones.count)) - oldCurrentMilestone.image.rawValue
        
        UserDefaultsManager.accomplishmentTotalSteps += Int(journeyData.currentSteps - goal.currentSteps)
        UserDefaultsManager.accomplishmentTotalMilestonesReached += Int(milestonesReached)
        UserDefaultsManager.accomplishmentTotalGoalsReached += (journeyData.currentState == .reached) ? 1 : 0
        

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
