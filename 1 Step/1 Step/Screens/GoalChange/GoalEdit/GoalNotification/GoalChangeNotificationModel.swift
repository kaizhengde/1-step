//
//  GoalNotificationModel.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

struct GoalChangeNotificationData {
    
    var time: Date
    var weekdays: [Int16]
}


class GoalChangeNotificationModel: ObservableObject {
    
    var goal: Goal { GoalModel.shared.selectedGoal }
    var notificationsUI: [GoalNotification] { Array(goal.notifications).sorted { $0.sortOrder < $1.sortOrder } }
    
    @Published var selectedData: GoalChangeNotificationData = GoalChangeNotificationData(time: Date(), weekdays: [])
    
    
    //MARK: - Weekdays
    
    lazy var weekdaysData: [String] = {
        let formatter = DateFormatter()
        var weekdays = formatter.shortStandaloneWeekdaySymbols!
        
        let firstWeekday = 2
        weekdays = Array(weekdays[firstWeekday-1..<weekdays.count]) + weekdays[0..<firstWeekday-1]
        
        return weekdays
    }()

    
    func getDescription(from weekdays: [Int16]) -> String {
        var descriptionArray: [String] = []
        var description: String = ""
        
        for weekday in weekdays.sorted() {
            var prevWeekday = weekday-1
            
            if !weekdays.contains(prevWeekday) {
                descriptionArray.append("\(weekday)")
                continue
            }
            
            while weekdays.contains(prevWeekday) {
                descriptionArray.removeAll { $0.contains("\(prevWeekday)") }
                descriptionArray.removeAll { $0.contains("\(weekday)") }
                descriptionArray.append("\(prevWeekday)-\(weekday)")
                prevWeekday -= 1
            }
        }

        if weekdays.count == 7 {
            description = Localized.everyDay
        } else {
            for weekday in descriptionArray {
                description += "\(weekday), "
            }
            description.removeLast(2)
            
            for weekday in weekdays.sorted() {
                description = description.replacingOccurrences(of: "\(weekday)", with: "\(weekdaysData[Int(weekday)])")
            }
        }
        
        return description
    }
    
    
    //MARK: - UI
    
    func showAddTimeView(with notification: GoalNotification?, _ selectedColor: UserColor) {
        resetSelectedData()
        
        if let notification = notification {
            selectedData.time = notification.time
            selectedData.weekdays = notification.weekdays
        }
        
        LocalNotificationManager.isAuthorized {
            MiniSheetManager.shared.showCustomMiniSheet(backgroundColor: selectedColor.standard, height: 600*Layout.multiplierWidth) {
                GoalChangeNotificationAddTimeView(viewModel: self, selectedColor: selectedColor, notification: notification)
            }
        }
    }

    
    //MARK: - Data
    
    func saveButtonPressed() {
        let notificationData: Goal.NotificationData = (UUID(), selectedData.time, selectedData.weekdays)
        
        GoalNotificationManager.sceduleNotifications(with: notificationData, of: self.goal) { error in
            if error == nil {
                DataModel.shared.addGoalNotification(self.goal, with: notificationData) {
                    MiniSheetManager.shared.dismiss()
                    self.resetSelectedData()
                    
                }
            }
        }
    }
    
    
    func editButtonPressed(with notification: GoalNotification) {
        let notificationData: Goal.NotificationData = (notification.id, selectedData.time, selectedData.weekdays)
        
        GoalNotificationManager.removeNotifications(with: notification.id, of: self.goal)
        GoalNotificationManager.sceduleNotifications(with: notificationData, of: self.goal) { error in
            if error == nil {
                DataModel.shared.editGoalNotification(notification, with: notificationData) {
                    MiniSheetManager.shared.dismiss()
                    self.resetSelectedData()
                }
            }
        }
    }
    
    
    func deleteButtonPressed(with notification: GoalNotification) {
        GoalNotificationManager.removeNotifications(with: notification.id, of: self.goal)
        
        DataModel.shared.removeGoalNotification(notification, of: goal) {
            MiniSheetManager.shared.dismiss()
            self.resetSelectedData()
        }
    }
    
    
    private let notificationsNoAccessSubscriber = PopupManager.shared.dismissed.sink {
        if $0 == .notificationsNoAccess { UIApplication.shared.openOneSSettings() }
    }
    
    
    func resetSelectedData() {
        selectedData = GoalChangeNotificationData(time: Date(), weekdays: [])
    }
}
