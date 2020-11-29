//
//  GoalNotificationModel.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalChangeNotificationData {
    
    var time: Date
    var weekdays: [Int]
}


class GoalChangeNotificationModel: ObservableObject {
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    
    var notificationsUI: [GoalNotification] { Array(goal.notifications) }
    
    @Published var selectedData: GoalChangeNotificationData = GoalChangeNotificationData(time: Date(), weekdays: [])
    
    lazy var weekdaysData: [String] = {
        let formatter = DateFormatter()
        var weekdays = formatter.shortStandaloneWeekdaySymbols!
        
        let firstWeekday = 2
        weekdays = Array(weekdays[firstWeekday-1..<weekdays.count]) + weekdays[0..<firstWeekday-1]
        
        return weekdays
    }()

    
    //MARK: - Data
    
    func finishButtonPressed() {
        let notificationData: Goal.NotificationData = (UUID(), selectedData.time, selectedData.weekdays.map { Int16($0) })
        
        GoalNotificationManager.sceduleNotifications(with: notificationData, of: self.goal) { error in
            if error == nil {
                DataModel.shared.addGoalNotification(self.goal, with: notificationData) { success in
                    if success {
                        MiniSheetManager.shared.dismiss()
                        self.resetSelectedData()
                    }
                }
            }
        }
    }
    
    private let notificationsNoAccessSubscriber = PopupManager.shared.dismissed.sink {
        if $0 == .notificationsNoAccess { UIApplication.shared.openOneSSettings() }
    }
    
    
    func resetSelectedData() {
        selectedData = GoalChangeNotificationData(time: Date(), weekdays: [])
    }
}
