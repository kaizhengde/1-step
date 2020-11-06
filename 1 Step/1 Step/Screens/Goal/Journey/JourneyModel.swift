//
//  JourneyModel.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI
import CoreData

class JourneyModel: ObservableObject {
    
    @Published var milestoneViewSize: CGSize = .zero

    @Published var milestoneAppears: [NSManagedObjectID: Bool] = [:]
    @Published var milestoneRects: [NSManagedObjectID: CGRect] = [:]
    
    @Published var stepPositions: [Int: CGPoint] = [:]
    
    init() { updateLineHeight() }
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    var milestonesUI: [Milestone] {
        Array(goal.milestones)
            .sorted { $0.neededStepUnits > $1.neededStepUnits }
            .filter { $0.image != .summit }
    }
    
    var summitMilestone: Milestone {
        goal.milestones.filter { $0.image == .summit }.first!
    }
    
    var currentMilestone: Milestone? {
        goal.milestones.filter { $0.state == .current }.first
    }
    
    var currentMilestoneAppear: Bool {
        return milestoneAppears[currentMilestone!.objectID] ?? false
    }
    
    var lastMilestone: Milestone { milestonesUI.last! }
    
    
    //MARK: - Animation Handling
    
    /*
     ---Case distinction---
     
     ---Normal add
     1. Move `progressView` to next current
     1. Move to current (next current step) accordingly
     1. Change `milestoneView` accordingly so that we have all invariants forfilled
     
     Note: MilestoneView's background height should *not* depend directly on the number of milestones - rather a calculated height indirectly as a background ZStack for example and aligned properly. Reason: Animation would be independent aswell!
     
     ---Milestone finish
     1. Move `progressView` to reached milestone
     1. Move to current (reached milestone) accordingly
     1. Change current milestone state - from current to done
     2. Close `milestoneView` of reached milestone
     3. Open `milestoneView` of next milestone
     4. Move `progressView` to next current
     4. Move to current (next current step) accordingly
     
     
     
     
     
     
     
     
     
     
     */
    
    
    
    
    
    
    
    
    
    //MARK: - Layout
    
    @Published var lineHeight: CGFloat = .zero
    
    
    func updateLineHeight() {
        let currentStepPosition = stepPositions[Int(goal.currentSteps)]?.y ?? 0
        var lastMilestoneBottom = milestoneRects[lastMilestone.objectID]?.maxY ?? 0
        
        if currentStepPosition == .zero {
            lastMilestoneBottom = .zero
        }
        
        lineHeight = abs(currentStepPosition-lastMilestoneBottom)
    }
    
    
    //MARK: - Step Preferences
    
    func updateStepPositions(_ preferences: StepPK.Value) {
        for p in preferences {
            stepPositions[p.steps] = p.position
        }
    }
    
    
    struct StepVS: View {
        
        let steps: Int
        
        
        var body: some View {
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: StepPK.self, value: [StepPD(steps: steps, position: proxy.frame(in: .journey).origin)])
            }
        }
    }
    
    
    struct StepPK: PreferenceKey {
        
        typealias Value = [StepPD]
        
        static var defaultValue: [StepPD] = []
        
        
        static func reduce(value: inout [StepPD], nextValue: () -> [StepPD]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    
    struct StepPD: Equatable {
        
        var steps: Int
        var position: CGPoint
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


extension VerticalAlignment {
    
    enum MilestoneAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }

    enum LineBottomAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    static let milestoneAlignment = Self(MilestoneAlignment.self)
    static let lineBottomAlignment = Self(LineBottomAlignment.self)
}


extension HorizontalAlignment {
    
    enum CurrentCircleTextAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    
    static let currentCircleTextAlignment = Self(CurrentCircleTextAlignment.self)
}
