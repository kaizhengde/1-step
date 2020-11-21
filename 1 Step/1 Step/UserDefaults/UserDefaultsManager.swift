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
                print("Success.")
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


enum UserDefaultsManager {
    
    //MARK: - First
    
    @UserDefault(key: UserDefaultKey.First.start) static var firstStart: Bool?
    @UserDefault(key: UserDefaultKey.First.selectMountain) static var firstSelectMountain: Bool?
    @UserDefault(key: UserDefaultKey.First.selectColor) static var firstSelectColor: Bool?
    @UserDefault(key: UserDefaultKey.First.enterInput) static var firstEnterInput: Bool?
    @UserDefault(key: UserDefaultKey.First.openGoal) static var firstOpenGoal: Bool?
    
    
    //MARK: - User
    
    @UserDefault(key: UserDefaultKey.User.name) static var userName: String?
    @UserDefault(key: UserDefaultKey.User.profileImage) static var userProfileImage: Data?
    
    
    //MARK: - Accomplishments
    
    @UserDefault(key: UserDefaultKey.Accomplishment.totalSteps) static var accomplishmentTotalSteps: Int?
    @UserDefault(key: UserDefaultKey.Accomplishment.totalMilestonesReached) static var accomplishmentTotalMilestonesReached: Int?
    @UserDefault(key: UserDefaultKey.Accomplishment.totalGoalsReached) static var accomplishmentTotalGoalsReached: Int?
    
    
    //MARK: - Settings
    
    @UserDefault(key: UserDefaultKey.Setting.premium) static var settingPremium: Bool?
    @UserDefault(key: UserDefaultKey.Setting.language) static var settingLanguage: OneSLanguage?
    @UserDefault(key: UserDefaultKey.Setting.darkmode) static var settingDarkmode: OneSDarkmode?
    @UserDefault(key: UserDefaultKey.Setting.colorTheme) static var settingColorTheme: OneSColorTheme?
    @UserDefault(key: UserDefaultKey.Setting.notifications) static var settingNotifications: Bool?
    @UserDefault(key: UserDefaultKey.Setting.iCloudSynch) static var settingICloudSynch: Bool?
}






