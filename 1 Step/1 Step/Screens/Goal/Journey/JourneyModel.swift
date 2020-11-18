//
//  JourneyModel.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI
import CoreData

final class JourneyModel: ObservableObject {
    
    @Published var milestoneAppears: [NSManagedObjectID: Bool] = [:]
    @Published var milestoneRects: [NSManagedObjectID: CGRect] = [:]
        
    var goal: Goal { MainModel.shared.currentScreen.active == .goal(.showActive) ? GoalModel.shared.selectedGoal : GoalReachedModel.shared.selectedGoal }
    
    var milestonesUI: [Milestone] {
        Array(goal.milestones)
            .sorted { $0.neededStepUnits > $1.neededStepUnits }
            .filter { $0.image != .summit }
    }
    
    var summitMilestone: Milestone {
        goal.milestones.filter { $0.image == .summit }.first!
    }
    
    var currentMilestone: Milestone {
        goal.milestones.filter { $0.state == .current }.first ?? Milestone(context: PersistenceManager.defaults.context)
    }
    
    var lastMilestone: Milestone {
        milestonesUI.last!
    }
    
    
    //MARK: - Milestone Preferences
    
    func updateMilestonePositions(_ preferences: MilestonePK.Value) {
        for p in preferences {
            milestoneRects[p.objectID] = p.rect

            if p.rect.minY <= Layout.screenHeight-200 {
                milestoneAppears[p.objectID] = true
            }
        }
    }


    struct MilestoneVS: View {

        let milestone: Milestone


        var body: some View {
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: MilestonePK.self, value: [MilestonePD(objectID: milestone.objectID, rect: proxy.frame(in: .journey))])
            }
        }
    }


    struct MilestonePK: PreferenceKey {

        typealias Value = [MilestonePD]

        static var defaultValue: [MilestonePD] = []

        static func reduce(value: inout [MilestonePD], nextValue: () -> [MilestonePD]) {
            value.append(contentsOf: nextValue())
        }
    }


    struct MilestonePD: Equatable {

        var objectID: NSManagedObjectID
        var rect: CGRect
    }
}



