//
//  GoalNotificationView.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalChangeNotificationView: View {
    
    @StateObject private var viewModel = GoalChangeNotificationModel()
    @ObservedObject var goalEditModel: GoalEditModel
    
    var selectedColor: UserColor { goalEditModel.selectedMountainData.color }
    
    
    var body: some View {
        OneSSectionView(title: "Reminders") {
            TimeReminderSection(selectedColor: selectedColor)
        }
        .padding(.top, 32*Layout.multiplierWidth)
        .oneSAnimation()
    }
    
    
    private struct TimeReminderSection: View {
        
        @StateObject private var miniSheetManager = MiniSheetManager.shared
        @StateObject private var viewModel = GoalChangeNotificationModel()
        
        var selectedColor: UserColor
        
        
        var body: some View {
            OneSDropDown(.long, title: "Time", accessorySFSymbol: SFSymbol.clock) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.notificationsUI, id: \.self) { notification in
                        OneSRowButton(.shortSmall, title: viewModel.getDescription(from: notification.weekdays), textColor: .backgroundToGray, backgroundColor: selectedColor.standard, accessoryText: notification.time.toTimeString(), accessoryColor: .backgroundToGray) {
                            
                            viewModel.selectedData.time = notification.time
                            viewModel.selectedData.weekdays = notification.weekdays
                            
                            miniSheetManager.showCustomMiniSheet(backgroundColor: selectedColor.standard, height: 600*Layout.multiplierHeight) {
                                GoalChangeNotificationAddTimeView(viewModel: viewModel, selectedColor: selectedColor, notification: notification)
                            }
                        }
                    }
                    
                    AddNotificationButton() {
                        viewModel.resetSelectedData()
                        miniSheetManager.showCustomMiniSheet(backgroundColor: selectedColor.standard, height: 600*Layout.multiplierHeight) {
                            GoalChangeNotificationAddTimeView(viewModel: viewModel, selectedColor: selectedColor, notification: nil)
                        }
                    }
                    .padding(.top, 20)
                }
                .frame(maxWidth: 280*Layout.multiplierWidth, alignment: .leading)
            }
        }
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
