//
//  AppDelegate.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaultsManager.shared.notificationBadgeCount = 0

        return true
    }
}
