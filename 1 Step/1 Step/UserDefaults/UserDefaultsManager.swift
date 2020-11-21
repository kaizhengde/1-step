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
        }
    }
}


protocol UserDefaultType {}

extension Data: UserDefaultType {}
extension String: UserDefaultType {}
extension Date: UserDefaultType {}
extension Bool: UserDefaultType {}
extension Int: UserDefaultType {}
extension Double: UserDefaultType {}
extension Float: UserDefaultType {}

extension Array: UserDefaultType where Element: UserDefaultType {}
extension Dictionary: UserDefaultType where Key == String, Value: UserDefaultType {}


enum UserDefaultsManager {
    
    //MARK: - First
    
    @UserDefault(UserDefaultKey.First.start, default: false) static var firstStart: Bool
    @UserDefault(UserDefaultKey.First.selectMountain, default: false) static var firstSelectMountain: Bool
    @UserDefault(UserDefaultKey.First.selectColor, default: false) static var firstSelectColor: Bool
    @UserDefault(UserDefaultKey.First.enterInput, default: false) static var firstEnterInput: Bool
    @UserDefault(UserDefaultKey.First.openGoal, default: false) static var firstOpenGoal: Bool
    
    
    //MARK: - User
    
    @UserDefault(UserDefaultKey.User.name, default: "") static var userName: String
    @UserDefault(UserDefaultKey.User.profileImage, default: Data()) static var userProfileImage: Data
    
    
    //MARK: - Accomplishments
    
    @UserDefault(UserDefaultKey.Accomplishment.totalSteps, default: 0) static var accomplishmentTotalSteps: Int
    @UserDefault(UserDefaultKey.Accomplishment.totalMilestonesReached, default: 0) static var accomplishmentTotalMilestonesReached: Int
    @UserDefault(UserDefaultKey.Accomplishment.totalGoalsReached, default: 0) static var accomplishmentTotalGoalsReached: Int
    
    
    //MARK: - Settings
    
    @UserDefault(UserDefaultKey.Setting.premium, default: false) static var settingPremium: Bool
    @UserDefault(UserDefaultKey.Setting.language, default: .english) static var settingLanguage: OneSLanguage
    @UserDefault(UserDefaultKey.Setting.darkmode, default: .light) static var settingDarkmode: OneSDarkmode
    @UserDefault(UserDefaultKey.Setting.colorTheme, default: .default) static var settingColorTheme: OneSColorTheme
    @UserDefault(UserDefaultKey.Setting.notifications, default: false) static var settingNotifications: Bool
    @UserDefault(UserDefaultKey.Setting.iCloudSynch, default: false) static var settingICloudSynch: Bool
}






