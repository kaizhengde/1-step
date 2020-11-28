//
//  GoalNotificationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import UserNotifications

enum GoalNotificationManager {
    
    static private let center = UNUserNotificationCenter.current()
    
    
    static func sceduleNotifications(with notificationData: Goal.NotificationData, of goal: Goal, completion: @escaping (Error?) -> ()) {
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addNotifications(notificationData, goal) { error in
                    DispatchQueue.main.async { completion(error) }
                }
            } else {
                LocalNotificationManager.requestAuthorization() { success in
                    if success {
                        addNotifications(notificationData, goal) { error in
                            DispatchQueue.main.async { completion(error) }
                        }
                    }
                }
            }
        }
    }
    
    
    static private func addNotifications(_ notificationData: Goal.NotificationData, _ goal: Goal, _ completion: @escaping (Error?) -> ()) {
        
        let notificationTitle: String = "\(goal.name) \(goal.neededStepUnits) \(goal.step.unit)"
        let notificationBody: String = "Just one more \(goal.step.unit)!\nThis will have an exponential effect on your success."
        
        var dateComponents = DateComponents()
        dateComponents.calendar = .current
        dateComponents.hour = Calendar.current.component(.hour, from: notificationData.time)
        dateComponents.minute = Calendar.current.component(.minute, from: notificationData.time)
        
        for weekday in notificationData.weekdays {
            dateComponents.weekday = Int(weekday+1)
            
            let content = UNMutableNotificationContent()
            content.title = notificationTitle
            content.body = notificationBody
            content.sound = UNNotificationSound.default
            
            print("New Notification Time: \(dateComponents.description)")
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: notificationData.id.uuidString, content: content, trigger: trigger)

            center.add(request) { error in
                guard error == nil else {
                    PopupManager.shared.showTextPopup(.none, titleText: "Error", bodyText: error!.localizedDescription, backgroundColor: .grayToBackground)
                    completion(error)
                    return
                }
            }
        }
        
        completion(nil)
    }
}
