//
//  GoalNotificationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import UserNotifications

struct GoalNotification {
    let id: UUID
    let title: String
    let body: String
    let dateComponents: DateComponents
}


enum GoalNotificationManager {
    
    static private let center = UNUserNotificationCenter.current()
    
    
    static func sceduleNotification(with notification: GoalNotification, completion: @escaping (Error?) -> ()) {
        
        let addNotification = {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default

            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponents, repeats: true)

            let request = UNNotificationRequest(identifier: notification.id.uuidString, content: content, trigger: trigger)

            center.add(request) { error in
                guard error == nil else {
                    PopupManager.shared.showTextPopup(.none, titleText: "Error", bodyText: error!.localizedDescription, backgroundColor: .grayToBackground)
                    DispatchQueue.main.async { completion(error) }
                    return
                }
            }
            
            completion(nil)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addNotification()
            } else {
                LocalNotificationManager.requestAuthorization() { success in
                    if success { addNotification() }
                }
            }
        }
    }
}
