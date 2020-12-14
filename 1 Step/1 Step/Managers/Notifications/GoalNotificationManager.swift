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
    
    static let userInfoGoalObjectIDKey = "GoalObjectIDKey"
    
    
    static func sceduleNotifications(with notificationData: Goal.NotificationData, of goal: Goal, completion: @escaping (Error?) -> ()) {
        
        LocalNotificationManager.isAuthorized {
            addNotifications(notificationData, goal) { error in
                DispatchQueue.main.async { completion(error) }
            }
        }
    }

    
    static private func addNotifications(_ notificationData: Goal.NotificationData, _ goal: Goal, _ completion: @escaping (Error?) -> ()) {
        let dateComponents  = setupNotificationsDateComponents(with: notificationData)
        let content         = setupNotificationContent(of: goal, with: dateComponents)
        
        for weekday in notificationData.weekdays {
            
            let weekdayDateComponents   = getNotificationDateComponents(of: weekday, with: dateComponents)
            let trigger                 = UNCalendarNotificationTrigger(dateMatching: weekdayDateComponents, repeats: true)
            let identifier              = "\(notificationData.id.uuidString)-\(weekdayDateComponents.weekday!)"
            
            let request                 = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            center.add(request) { error in
                guard error == nil else {
                    PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral) {
                        OneSTextPopupView(titleText: "Error", bodyText: error!.localizedDescription)
                    }
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


//MARK: - Notification Content

extension GoalNotificationManager {
    
    //MARK: - DateComponents
    
    static private func setupNotificationsDateComponents(with notificationData: Goal.NotificationData) -> DateComponents {
        var dateComponents      = DateComponents()
        dateComponents.calendar = .current
        dateComponents.hour     = Calendar.current.component(.hour, from: notificationData.time)
        dateComponents.minute   = Calendar.current.component(.minute, from: notificationData.time)
        
        return dateComponents
    }
    
    
    static private func getNotificationDateComponents(of weekday: Int16, with datecomponents: DateComponents) -> DateComponents {
        var dateComponents = datecomponents
        
        let sundayStartWeekday  = Int(weekday+1 == 7 ? 0 : weekday+1)
        dateComponents.weekday  = sundayStartWeekday+1
        
        print("New Notification: \(dateComponents.description)")
        
        return dateComponents
    }
    
    
    //MARK: - Content
    
    static private func setupNotificationContent(of goal: Goal, with dateComponents: DateComponents) -> UNNotificationContent {
        let notificationTitle: String   = "\(goal.name) \(goal.neededStepUnits) \(goal.step.unitDescription)"
        var notificationBody: String    = NotificationHelper.generateNotificationGreeting(from: dateComponents)
        
        notificationBody.append(" \(Localized.Notification.goal_bodyText)")
        
        let content     = UNMutableNotificationContent()
        content.title   = notificationTitle
        content.body    = notificationBody
        content.sound   = UNNotificationSound.init(named: UNNotificationSoundName(NotificationSound.default))
        content.userInfo[userInfoGoalObjectIDKey] = goal.objectID.uriRepresentation().absoluteString
        
        return content
    }
}
