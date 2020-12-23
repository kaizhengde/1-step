//
//  MainModel.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct Screen {
    
    enum Active: Equatable {
        
        enum GoalScreenShowState {
            case transition, showActive, showReached
        }
        
        case none
        case goals
        case goalAdd
        case firstStart
        case goal(GoalScreenShowState)
        case profile

        func isScreen(_ screen: Self) -> Bool {
            switch screen {
            case .none: return self == .none
            case .goals: return self == .goals || self == .goal(.transition)
            case .goalAdd: return self == .goalAdd
            case .firstStart: return self == .firstStart
            case .goal(.transition): return self == .goal(.transition)
            case .goal(.showActive): return self == .goal(.showActive)
            case .goal(.showReached): return self == .goal(.showReached)
            case .profile: return self == .profile
            }
        }
    }

    
    var active: Active = .none
    var opacity: Double = 1.0

    mutating func dismiss() { opacity = 0.0 }
    mutating func show() { opacity = 1.0 }
}


final class MainModel: ObservableObject {
    
    static let shared = MainModel()
    
    @Published private(set) var currentScreen: Screen = Screen()
    @Published var appLaunched = false
    
    private init() {
        if UserDefaultsManager.shared.settingFaceTouchID {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                LockViewManager.shared.showLockView()
            }
        }
        else { launchApp() }
    }
    
    func launchApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let initialScreen: Screen.Active = UserDefaultsManager.shared.firstStart ? .firstStart : .goals
            self.currentScreen.active = initialScreen
            self.appLaunched = true
        }
    }
    
    
    func toScreen(_ nextScreen: Screen.Active) {
        currentScreen.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.opacity) {
            self.currentScreen.active = nextScreen
            self.currentScreen.show()
        }
    }
    
    
    func screen<Content: View>(_ screen: Screen.Active, content: () -> Content) -> some View {
        Group {
            if currentScreen.active.isScreen(screen) {
                if screen == .goal(.transition) {
                    content()
                } else {
                    content().opacity(currentScreen.opacity)
                }
            }
        }
    }
    
    
    func toGoalScreen(_ state: GoalState) {
        currentScreen.active = .goal(.transition)
        currentScreen.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Animation.Delay.oneS) {
            self.currentScreen.dismiss()
            self.currentScreen.active = .goal(state == .active ? .showActive : .showReached)
            self.currentScreen.show()
        }
    }
    
    
    //MARK: - Window
        
    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
    
    
    //MARK: - Updates
    
    func considerUserDefaults() {
        updateAppearance()
        updateNotificationAuthorization()
        updateICloudSettings()
        updateICloudDefaults()
    }
    
    
    func updateAppearance() {
        let currentAppearance = UserDefaultsManager.shared.settingAppearance
        
        switch currentAppearance {
        case .mirrorDevice: window?.overrideUserInterfaceStyle = .unspecified
        case .light:        window?.overrideUserInterfaceStyle = .light
        case .dark:         window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    
    private func updateNotificationAuthorization() {
        LocalNotificationManager.listenToAuthorizationStatus()
    }
    
    
    private func updateICloudSettings() {
        let iCloudToken = FileManager.default.ubiquityIdentityToken
        
        if iCloudToken == nil {
            UserDefaultsManager.shared.settingICloudSynch = false
        } else {
            if UserDefaultsManager.shared.settingICloudSynch {
                PersistenceManager.defaults.updateContainer()
            }
        }
    }
    
    
    private func updateICloudDefaults() {
        UserDefaultsManager.shared.syncAllICloudDefaults()
    }
}



