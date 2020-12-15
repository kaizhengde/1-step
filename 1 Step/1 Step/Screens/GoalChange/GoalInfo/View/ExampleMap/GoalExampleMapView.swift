//
//  GoalExampleMapView.swift
//  1 Step
//
//  Created by Kai Zheng on 20.11.20.
//

import SwiftUI

struct GoalExampleMapView: View {
    
    let data: [GoalExampleData]
    let selectedColor: UserColor
    let big: Bool
    
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<data.count, id: \.self) { i in
                if data[i].final {
                    GoalExampleBackgroundText(text: data[i].text, backgroundColor: selectedColor.standard, big: big)
                } else {
                    GoalExampleBackgroundText(text: data[i].text, backgroundColor: selectedColor.light, big: big)
                    GoalExampleArrowText(text: data[i].arrowText.description, big: big)
                }
            }
        }
        .padding(.bottom, 12)
    }
}
