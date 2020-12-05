//
//  AppDelegate.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaultsManager.shared.notificationBadgeCount = 0
                
        return true
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        //Goal Notification
        
        if let objectIDURLString = userInfo[GoalNotificationManager.userInfoGoalObjectIDKey] as? String {
            if let objectIDURL = URL(string: objectIDURLString) {
                
                let coordinator = PersistenceManager.defaults.container.persistentStoreCoordinator
                
                if let objectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL) {
                    let goal = PersistenceManager.defaults.context.object(with: objectID) as! Goal
                    
                    GoalModel.shared.selectedGoal = goal
                    GoalModel.shared.objectWillChange.send()
                    
                    if MainModel.shared.initialScreenAppeared {
                        FullSheetManager.shared.dismiss()
                        SheetManager.shared.dismiss()
                        MiniSheetManager.shared.dismiss()
                        PopupManager.shared.dismiss()
                        
                        if MainModel.shared.currentScreen.active != .goal(.showActive) {
                            MainModel.shared.toGoalScreen(.active)
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            MainModel.shared.toGoalScreen(.active)
                        }
                    }
                }
            }
        }
    }
}

