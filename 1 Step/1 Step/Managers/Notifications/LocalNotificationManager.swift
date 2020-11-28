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
                    PopupManager.shared.showTextPopup(.none, titleText: "Error", bodyText: error!.localizedDescription, backgroundColor: .grayToBackground)
                    return
                }
                
                if granted {
                    completion(true)
                    return
                }
            }
        
        completion(false)
    }
    
    
    static func updateAuthorization() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkAuthorizationStatus), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    @objc static private func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            UserDefaultsManager.shared.authorizationNotifications = settings.authorizationStatus
        }
    }
}

