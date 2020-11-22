//
//  ProfileModel.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

class ProfileModel: ObservableObject {

    //MARK: - Section 0: Accomplishments
    
    let accomplishmentsData: [(description: String, value: Int, color: Color, appearDelay: DispatchTimeInterval)] = [
        ("Steps in total", UserDefaultsManager.shared.accomplishmentTotalSteps, UserColor.user0.get(), DelayAfter.none),
        ("Milestones reached", UserDefaultsManager.shared.accomplishmentTotalMilestonesReached, UserColor.user1.get(), DelayAfter.halfOpacity),
        ("Goals completed", UserDefaultsManager.shared.accomplishmentTotalGoalsReached, UserColor.user2.get(), DelayAfter.halfOpacity)
    ]
    
    
    //MARK: - Section 1: App
    
    let section1Color = UserColor.user0.get()
    
    func appSelectedRowBackgroundColor(_ state: Bool) -> Color {
        return state ? section1Color : .whiteToDarkGray
    }
    
    
    func appSelectedRowTitleColor(_ state: Bool) -> Color {
        return state ? .whiteToDarkGray : .grayToBackground
    }
    
    
    func appSelectedRowAccessoryColor(_ state: Bool) -> Color {
        return state ? .whiteToDarkGray : section1Color
    }
    
    
    func appSelectedRowAccessoryText(_ state: Bool, enabled: String, disabled: String) -> String {
        return state ? enabled : disabled
    }
}
