//
//  JourneyModel.swift
//  1 Step
//
//  Created by Kai Zheng on 30.10.20.
//

import SwiftUI

class JourneyModel: ObservableObject {
    
    @Published var rects: [CGRect] = []
    
    init(milestonesAmount: Int) {
        rects = Array<CGRect>(repeating: .zero, count: milestonesAmount)
    }
    
    
    func updatePreferences(_ preferences: MilestonePK.Value) {
        for p in preferences {
            rects[Int(p.milestoneID)] = p.rect
        }
    }


    struct MilestoneVS: View {
        let mountainID: MountainImage.RawValue
        
        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: MilestonePK.self, value: [MilestonePD(milestoneID: self.mountainID, rect: geometry.frame(in: .selectMountain))])
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
        var milestoneID: MountainImage.RawValue
        var rect: CGRect
    }

}


extension VerticalAlignment {
    
    enum MilestoneAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    
    enum ProgressStartAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    
    static let milestoneAlignment = Self(MilestoneAlignment.self)
    static let progressStartAlignment = Self(ProgressStartAlignment.self)
}


