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
    @Published var currentMilestoneAppear: Bool = false
}


extension VerticalAlignment {
    
    enum MilestoneAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    enum ProgressCurrentAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    
    static let milestoneAlignment = Self(MilestoneAlignment.self)
    static let progressCurrentAlignment = Self(ProgressCurrentAlignment.self)
}


extension HorizontalAlignment {
    
    enum CurrentCircleTextAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    
    static let currentCircleTextAlignment = Self(CurrentCircleTextAlignment.self)
}
