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
    @Published var currentStepPosition: CGPoint = .zero
    
    
    //MARK: - Step Preferences
    
    func updateCurrentStepPosition(_ preference: StepPK.Value) {
        currentStepPosition = preference[0]
    }
    
    
    struct StepVS: View {
        
        var body: some View {
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: StepPK.self, value: [proxy.frame(in: .journey).origin])
            }
        }
    }
    
    
    struct StepPK: PreferenceKey {
        
        typealias Value = [CGPoint]
        
        static var defaultValue: [CGPoint] = []
        
        
        static func reduce(value: inout [CGPoint], nextValue: () -> [CGPoint]) {
            value.append(contentsOf: nextValue())
        }
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
    
    enum LineLastMilestoneAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    static let milestoneAlignment = Self(MilestoneAlignment.self)
    static let lineLastMilestoneAlignment = Self(LineLastMilestoneAlignment.self)
}


extension HorizontalAlignment {
    
    enum CurrentCircleTextAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    
    static let currentCircleTextAlignment = Self(CurrentCircleTextAlignment.self)
}
