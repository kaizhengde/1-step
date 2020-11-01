//
//  JourneyProgressView.swift
//  1 Step
//
//  Created by Kai Zheng on 01.11.20.
//

import SwiftUI

struct JourneyProgressView: View {
    
    
    var body: some View {
        Group {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10)
                .frame(maxWidth: .infinity)
                .foregroundColor(.whiteToDarkGray)
                .alignmentGuide(.progressCurrentAlignment) { $0[.top] }
            
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.whiteToDarkGray)
                .alignmentGuide(.progressCurrentAlignment) { $0[VerticalAlignment.center] - 10 }
                .id(GoalModel.ScrollPosition.current)
        }
    }
}
