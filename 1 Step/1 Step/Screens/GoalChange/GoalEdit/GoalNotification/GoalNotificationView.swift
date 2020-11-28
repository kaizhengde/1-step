//
//  GoalNotificationView.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalNotificationView: View {
    
    @ObservedObject var goalEditModel: GoalEditModel
    var selectedColor: Color { goalEditModel.selectedMountainData.color.standard }
    
    
    var body: some View {
        OneSSectionView(title: "Reminders") {
            OneSDropDown(.long, title: "Time", accessorySFSymbol: SFSymbol.clock) {
                OneSRowButton(.shortSmall, title: "Everyday", textColor: .backgroundToGray, backgroundColor: selectedColor, accessoryText: "12:30", accessoryColor: .backgroundToGray) {
                }
            }
        }
        .padding(.vertical, 40*Layout.multiplierWidth)
        .oneSAnimation()
    }
}
