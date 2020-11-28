//
//  UserDefaultsKeys.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

struct UserDefaultKey: RawRepresentable {
    let rawValue: String
}


extension UserDefaultKey: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}


extension UserDefaultKey {
    
    typealias Key = UserDefaultKey
    
    enum First {
        static let start: Key                    = "first.start"
        static let selectMountain: Key           = "first.selectMountain"
        static let selectColor: Key              = "first.selectColor"
        static let enterInput: Key               = "first.enterInput"
        static let openGoal: Key                 = "first.openGoal"
    }
    
    
    enum User {
        static let name: Key                     = "user.name"
        static let profileImage: Key             = "user.profileImage"
    }
    
    
    enum Accomplishment {
        static let totalSteps: Key               = "accomplishment.totalSteps"
        static let totalMilestonesReached: Key   = "accomplishment.totalMilestonesReached"
        static let totalGoalsReached: Key        = "accomplishment.totalGoalsReached"
    }
    
    
    enum Setting {
        static let premium: Key                  = "setting.premium"
        static let language: Key                 = "setting.language"
        static let appearance: Key               = "setting.appearance"
        static let colorTheme: Key               = "setting.colorTheme"
        static let iCloudSynch: Key              = "setting.iCloudSynch"
    }
    
    
    enum Authorization {
        static let notifications: Key           = "authorization.notifications"
        static let photoLibrary: Key            = "authorization.photoLibrary"
    }
}



