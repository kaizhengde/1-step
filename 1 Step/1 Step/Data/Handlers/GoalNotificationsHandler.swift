//
//  GoalNotificationsHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 30.11.20.
//

import Foundation

enum GoalNotificationsHandler {
    
    static func updateAfterGoalEdit(with goal: Goal) {
        for notification in goal.notifications {
            GoalNotificationManager.removeNotifications(with: notification.id, of: goal)
            let notificationData: Goal.NotificationData = (notification.id, notification.time, notification.weekdays)
            GoalNotificationManager.sceduleNotifications(with: notificationData, of: goal) { _ in }
        }
    }
    
    
    static func deleteAllNotifications(with goal: Goal) {
        for notification in goal.notifications {
            GoalNotificationManager.removeNotifications(with: notification.id, of: goal)
        }
    }
}
