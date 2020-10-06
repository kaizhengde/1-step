//
//  GoalSelectMountainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

class GoalSelectMountainModel: ObservableObject {
    
    @Published var currentMountain: CGFloat = .zero
    @Published var dragOffset: CGSize = .zero
    @Published var rects: [CGRect] = Array<CGRect>(repeating: .zero, count: MountainImage.allCases.count)
    
    
    struct MountainVS: View {
        let mountainID: MountainImage.RawValue
        
        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: MountainPK.self, value: [MountainPD(mountainID: self.mountainID, rect: geometry.frame(in: .selectMountain))])
            }
        }
    }
    

    struct MountainPK: PreferenceKey {
        typealias Value = [MountainPD]
        
        static var defaultValue: [MountainPD] = []
        
        static func reduce(value: inout [MountainPD], nextValue: () -> [MountainPD]) {
            value.append(contentsOf: nextValue())
        }
    }
    

    struct MountainPD: Equatable {
        var mountainID: MountainImage.RawValue
        var rect: CGRect
    }
}



