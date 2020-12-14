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
        OneSSectionView(title: Localized.reminders) {
            TimeReminderSection(selectedColor: selectedColor)
        }
        .padding(.top, 32*Layout.multiplierWidth)
        .oneSAnimation()
    }
    
    
    private struct TimeReminderSection: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @StateObject private var viewModel = GoalChangeNotificationModel()
        
        var selectedColor: UserColor
        var notifications: Bool { userDefaultsManager.authorizationNotifications == .authorized }
        
        
        var body: some View {
            OneSDropDown(.long, title: Localized.time, accessorySFSymbol: SFSymbol.clock) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.notificationsUI, id: \.self) { notification in
                        OneSRowButton(.shortSmall, title: viewModel.getDescription(from: notification.weekdays), textColor: .backgroundToGray, backgroundColor: notifications ? selectedColor.standard : .lightNeutralToLightGray, accessoryText: notification.time.toTimeString(), accessoryColor: .backgroundToGray) {
                            viewModel.showAddTimeView(with: notification, selectedColor)
                        }
                    }
                    
                    if viewModel.goal.notifications.count < Goal.maxNotifications {
                        AddNotificationButton() {
                            viewModel.showAddTimeView(with: nil, selectedColor)
                        }
                        .padding(.top, 20)
                    }
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
