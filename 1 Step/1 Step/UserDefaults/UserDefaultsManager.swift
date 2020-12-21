//
//  UserDefaultsManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI
import Combine

class UserDefaultsManager: ObservableObject {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    static let syncICloudDefaults = PassthroughSubject<Void, Never>()
    
    func syncAllICloudDefaults() {
        if settingICloudSynch {
            UserDefaultsManager.syncICloudDefaults.send()
        }
    }
    
    
    //MARK: - First
    
    @UserDefaultICloud(UserDefaultKey.First.start,            default: true) var firstStart: Bool
    @UserDefaultICloud(UserDefaultKey.First.selectMountain,   default: true) var firstSelectMountain: Bool
    @UserDefaultICloud(UserDefaultKey.First.selectColor,      default: true) var firstSelectColor: Bool
    @UserDefaultICloud(UserDefaultKey.First.openGoal,         default: true) var firstOpenGoal: Bool
    
    
    //MARK: - User
    
    @UserDefaultICloud(UserDefaultKey.User.name,          default: "")        var userName: String
    @UserDefaultICloud(UserDefaultKey.User.profileImage,  default: Data())    var userProfileImage: Data
    
    
    //MARK: - Accomplishments
    
    @UserDefaultICloud(UserDefaultKey.Accomplishment.totalSteps,              default: 0) var accomplishmentTotalSteps: Int
    @UserDefaultICloud(UserDefaultKey.Accomplishment.totalMilestonesReached,  default: 0) var accomplishmentTotalMilestonesReached: Int
    @UserDefaultICloud(UserDefaultKey.Accomplishment.totalGoalsReached,       default: 0) var accomplishmentTotalGoalsReached: Int
    
    
    //MARK: - Settings
    
    @UserDefault(UserDefaultKey.Setting.premium,        default: false)         var settingPremium: Bool
    @UserDefault(UserDefaultKey.Setting.appearance,     default: .mirrorDevice) var settingAppearance: OneSAppearance
    @UserDefault(UserDefaultKey.Setting.colorTheme,     default: .water)        var settingColorTheme: OneSColorTheme
    @UserDefault(UserDefaultKey.Setting.iCloudSynch,    default: false)         var settingICloudSynch: Bool
    @UserDefault(UserDefaultKey.Setting.faceTouchID,    default: false)         var settingFaceTouchID: Bool
    
    
    //MARK: - Authorization
    
    @UserDefault(UserDefaultKey.Authorization.notifications,    default: .notDetermined) var authorizationNotifications: UNAuthorizationStatus
    @UserDefault(UserDefaultKey.Authorization.photoLibrary,     default: .none)          var authorizationPhotoLibrary: OneSAuthorizationStatus
    
    
    //MARK: - Notification
    
    @UserDefault(UserDefaultKey.Notification.badgeCount, default: 0) var notificationBadgeCount: Int
}
