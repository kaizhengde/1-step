//
//  GoalExamplesView.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

struct GoalExamplesView: View {
    
    let selectedColor: UserColor

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OneSDropDown(.shortBig, title: "Lose weight") {
                VStack(spacing: 10) {
                    GoalInfoBackgroundText(text: "Lose weight", backgroundColor: selectedColor.get(.light), big: false)
                    GoalInfoArrowText(text: "What?", big: false)
                    
                    GoalInfoBackgroundText(text: "Lose 20 pounds", backgroundColor: selectedColor.get(.light), big: false)
                    GoalInfoArrowText(text: "How?", big: false)
                    
                    GoalInfoBackgroundText(text: "Exercise more often", backgroundColor: selectedColor.get(.light), big: false)
                    GoalInfoArrowText(text: "What?", big: false)
                    
                    GoalInfoBackgroundText(text: "Go for a run regularly", backgroundColor: selectedColor.get(.light), big: false)
                    GoalInfoArrowText(text: "What?", big: false)
                    
                    GoalInfoBackgroundText(text: "Run 100 miles in total", backgroundColor: selectedColor.get(), big: false)
                }
                .padding(.bottom, 20)
            }
            
            OneSDropDown(.shortBig, title: "Become more aware") { EmptyView() }
            OneSDropDown(.shortBig, title: "Help the environment") { EmptyView() }
            OneSDropDown(.shortBig, title: "Get better at guitar") { EmptyView() }
            OneSDropDown(.shortBig, title: "Be more happy") { EmptyView() }
            OneSDropDown(.shortBig, title: "Stop procrastination") { EmptyView() }
            OneSDropDown(.shortBig, title: "Learn a new language") { EmptyView() }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
