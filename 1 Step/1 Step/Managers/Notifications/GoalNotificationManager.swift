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
        
        LocalNotificationManager.isAuthorized {
            addNotifications(notificationData, goal) { error in
                DispatchQueue.main.async { completion(error) }
            }
        }
    }

    
    static private func addNotifications(_ notificationData: Goal.NotificationData, _ goal: Goal, _ completion: @escaping (Error?) -> ()) {
        
        let notificationTitle: String = "\(goal.name) \(goal.neededStepUnits) \(Step.unitDescription(of: goal))"
        let notificationBody: String = "Hey 🙂. It's time to take one more step."
        
        var dateComponents = DateComponents()
        dateComponents.calendar = .current
        dateComponents.hour = Calendar.current.component(.hour, from: notificationData.time)
        dateComponents.minute = Calendar.current.component(.minute, from: notificationData.time)
        
        for weekday in notificationData.weekdays {
            let sundayStartWeekday = Int(weekday+1 == 7 ? 0 : weekday+1)
            dateComponents.weekday = sundayStartWeekday+1
            
            let content = UNMutableNotificationContent()
            content.title = notificationTitle
            content.body = notificationBody
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName("NoticiationDefault.m4r"))

            print("New Notification Time: \(dateComponents.description)")
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "\(notificationData.id.uuidString)-\(dateComponents.weekday!)", content: content, trigger: trigger)
            
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
    
    
    static func removeNotifications(with id: UUID, of goal: Goal) {
        var identifiers: [String] = []
        for weekday in 1...7 {
            identifiers.append("\(id.uuidString)-\(weekday)")
        }
        center.removePendingNotificationRequests(withIdentifiers: identifiers) 
    }
}
