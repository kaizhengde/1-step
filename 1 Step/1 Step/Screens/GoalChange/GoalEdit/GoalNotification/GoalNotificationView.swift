//
//  GoalNotificationView.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalNotificationView: View {
    
    @StateObject private var miniSheetManager = MiniSheetManager.shared
    @ObservedObject var goalEditModel: GoalEditModel
    var selectedColor: UserColor { goalEditModel.selectedMountainData.color }
    
    
    var body: some View {
        OneSSectionView(title: "Reminders") {
            OneSDropDown(.long, title: "Time", accessorySFSymbol: SFSymbol.clock) {
                VStack(alignment: .leading, spacing: 10) {
                    OneSRowButton(.shortSmall, title: "Everyday", textColor: .backgroundToGray, backgroundColor: selectedColor.standard, accessoryText: "12:30", accessoryColor: .backgroundToGray) {
                    }
                    
                    AddNotificationButton() {
                        miniSheetManager.showCustomMiniSheet(titleText: "New Reminder", backgroundColor: selectedColor.standard, height: 600*Layout.multiplierHeight) {
                            GoalNotificationAddTimeView(selectedColor: selectedColor)
                        }
                    }
                    .padding(.top, 20)
                }
            }
        }
        .padding(.top, 32*Layout.multiplierWidth)
        .oneSAnimation()
    }
    
    
    private struct AddNotificationButton: View {
        
        let action: () -> ()
        
        var body: some View {
            Button(action: action) {
                SFSymbol.plus
                    .font(OneSFont.custom(.light, 40).font)
                    .foregroundColor(.neutralToDarkNeutral)
                    .contentShape(Rectangle())
            }
        }
    }
}
