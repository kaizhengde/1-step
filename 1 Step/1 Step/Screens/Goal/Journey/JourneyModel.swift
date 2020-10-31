//
//  JourneyModel.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

enum JourneyModel {
    
    
}


extension VerticalAlignment {
    
    enum MilestoneAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    enum ProgressStartAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    static let milestoneAlignment = Self(MilestoneAlignment.self)
    static let progressStartAlignment = Self(ProgressStartAlignment.self)
}



