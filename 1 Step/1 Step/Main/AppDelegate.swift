//
//  AppDelegate.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI
import CoreData
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        setupNotifications()
        appWillEnterForeground()
        
        return true
    }
    
    
    private func setupNotifications() {
        UNUserNotificationCenter.current().delegate = self
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        //UserDefaultsManager.shared.notificationBadgeCount = 0
    }
    
    
    private func appWillEnterForeground() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            self.setupBiometricAuthentication()
        }
    }
    
    
    private func setupBiometricAuthentication() {
        if UserDefaultsManager.shared.settingFaceTouchID {
            LockViewManager.shared.showLockView()
        }
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
                    if MainModel.shared.appLaunched {
                        let goal = PersistenceManager.defaults.context.object(with: objectID) as! Goal
                        
                        GoalModel.shared.selectedGoal = goal
                        GoalModel.shared.objectWillChange.send()
                        
                        FullSheetManager.shared.dismiss()
                        SheetManager.shared.dismiss()
                        MiniSheetManager.shared.dismiss()
                        PopupManager.shared.dismiss()
                        
                        if MainModel.shared.currentScreen.active != .goal(.showActive) {
                            MainModel.shared.toGoalScreen(.active)
                        }
                    } else {
                        MainModel.shared.appLaunched = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            let goal = PersistenceManager.defaults.context.object(with: objectID) as! Goal
                            
                            GoalModel.shared.selectedGoal = goal
                            GoalModel.shared.objectWillChange.send()
                            
                            MainModel.shared.toGoalScreen(.active)
                        }
                    }
                }
            }
        }
    }
}

