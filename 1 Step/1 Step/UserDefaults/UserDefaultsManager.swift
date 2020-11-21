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

    var wrappedValue: T? {
        get {
            //UserDefaults.standard.value(forKey: key.rawValue) as? T
            guard let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data,
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                else { return nil }
            return decodedData
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
            }
            //UserDefaults.standard.set(newValue, forKey: key.rawValue)
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


struct UserDefaultsManager {
    
    //MARK: - First
    
    @UserDefault(key: UserDefaultKey.First.start) var firstStart: Bool?
    @UserDefault(key: UserDefaultKey.First.selectMountain) var firstSelectMountain: Bool?
    @UserDefault(key: UserDefaultKey.First.selectColor) var firstSelectColor: Bool?
    @UserDefault(key: UserDefaultKey.First.enterInput) var firstEnterInput: Bool?
    @UserDefault(key: UserDefaultKey.First.openGoal) var firstOpenGoal: Bool?
    
    
    //MARK: - User
    
    @UserDefault(key: UserDefaultKey.User.name) var userName: String?
    @UserDefault(key: UserDefaultKey.User.profileImage) var userProfileImage: Data?
    
    
    //MARK: - Accomplishments
    
    @UserDefault(key: UserDefaultKey.Accomplishment.totalSteps) var accomplishmentTotalSteps: Int?
    @UserDefault(key: UserDefaultKey.Accomplishment.totalMilestonesReached) var accomplishmentTotalMilestonesReached: Int?
    @UserDefault(key: UserDefaultKey.Accomplishment.totalGoalsReached) var accomplishmentTotalGoalsReached: Int?
    
    
    //MARK: - Settings
    
    @UserDefault(key: UserDefaultKey.Setting.premium) var settingPremium: Bool?
    @UserDefault(key: UserDefaultKey.Setting.language) var settingLanguage: OneSLanguage?
    @UserDefault(key: UserDefaultKey.Setting.darkmode) var settingDarkmode: OneSDarkmode?
    @UserDefault(key: UserDefaultKey.Setting.colorTheme) var settingColorTheme: OneSColorTheme?
    @UserDefault(key: UserDefaultKey.Setting.notifications) var settingNotifications: Bool?
    @UserDefault(key: UserDefaultKey.Setting.iCloudSynch) var settingICloudSynch: Bool?
}






