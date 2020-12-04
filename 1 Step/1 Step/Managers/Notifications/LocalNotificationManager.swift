//
//  LocalNotificationManager.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI
import UserNotifications

class LocalNotificationManager {
    
    static private let center = UNUserNotificationCenter.current()
    
    
    static func firstStartRequestAuthorization() {
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                requestAuthorization()
            }
        }
    }
    
    
    static func requestAuthorization(completion: @escaping (Bool) -> () = { _ in }) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard error == nil else {
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral) {
                    OneSTextPopupView(titleText: "Error", bodyText: error!.localizedDescription)
                }
                return
            }
            
            if granted {
                completion(true)
                return
            }
        }
        
        completion(false)
    }
    
    
    static func isAuthorized(completion: @escaping () -> ()) {
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                completion()
            } else {
                PopupManager.shared.showPopup(.notificationsNoAccess, backgroundColor: .darkNeutralToNeutral) {
                    OneSTextPopupView(titleText: "Error", bodyText: "Please grant permission for notifications.")
                }
            }
        }
    }
    
    
    static func listenToAuthorizationStatus() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkAuthorizationStatus), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    @objc static private func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            UserDefaultsManager.shared.authorizationNotifications = settings.authorizationStatus
        }
    }
}

