//
//  UserDefaultsManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

@propertyWrapper
struct UserDefault<T: UserDefaultType> where T: Codable {
    let key: UserDefaultKey
    let defaultValue: T
    
    init(_ key: UserDefaultKey, default: T) {
        self.key = key
        self.defaultValue = `default`
    }

    var wrappedValue: T {
        get {
            guard let data = (UserDefaults.standard.value(forKey: key.rawValue) ?? defaultValue) as? Data,
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                else { return defaultValue }
            return decodedData
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
                print("Success.")
            }
            DispatchQueue.main.async { UserDefaultsManager.shared.objectWillChange.send() }
        }
    }
}


class UserDefaultsManager: ObservableObject {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    
    //MARK: - First
    
    @UserDefault(UserDefaultKey.First.start, default: true) var firstStart: Bool
    @UserDefault(UserDefaultKey.First.selectMountain, default: true) var firstSelectMountain: Bool
    @UserDefault(UserDefaultKey.First.selectColor, default: true) var firstSelectColor: Bool
    @UserDefault(UserDefaultKey.First.enterInput, default: true) var firstEnterInput: Bool
    @UserDefault(UserDefaultKey.First.openGoal, default: true) var firstOpenGoal: Bool
    
    
    //MARK: - User
    
    @UserDefault(UserDefaultKey.User.name, default: "") var userName: String
    @UserDefault(UserDefaultKey.User.profileImage, default: Data()) var userProfileImage: Data
    
    
    //MARK: - Accomplishments
    
    @UserDefault(UserDefaultKey.Accomplishment.totalSteps, default: 0) var accomplishmentTotalSteps: Int
    @UserDefault(UserDefaultKey.Accomplishment.totalMilestonesReached, default: 0) var accomplishmentTotalMilestonesReached: Int
    @UserDefault(UserDefaultKey.Accomplishment.totalGoalsReached, default: 0) var accomplishmentTotalGoalsReached: Int
    
    
    //MARK: - Settings
    
    @UserDefault(UserDefaultKey.Setting.premium, default: false) var settingPremium: Bool
    @UserDefault(UserDefaultKey.Setting.language, default: .english) var settingLanguage: OneSLanguage
    @UserDefault(UserDefaultKey.Setting.appearance, default: .light) var settingAppearance: OneSAppearance 
    @UserDefault(UserDefaultKey.Setting.colorTheme, default: .default) var settingColorTheme: OneSColorTheme
    @UserDefault(UserDefaultKey.Setting.iCloudSynch, default: false) var settingICloudSynch: Bool
    
    
    //MARK: - Authorization
    
    @UserDefault(UserDefaultKey.Authorization.notifications, default: .notDetermined) var authorizationNotifications: UNAuthorizationStatus
    @UserDefault(UserDefaultKey.Authorization.photoLibrary, default: .none) var authorizationPhotoLibrary: OneSAuthorizationStatus
}


