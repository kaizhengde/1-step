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
        ("Steps in total", UserDefaultsManager.accomplishmentTotalSteps, UserColor.user0.get(), DelayAfter.none),
        ("Milestones reached", UserDefaultsManager.accomplishmentTotalMilestonesReached, UserColor.user1.get(), DelayAfter.halfOpacity),
        ("Goals completed", UserDefaultsManager.accomplishmentTotalGoalsReached, UserColor.user2.get(), DelayAfter.halfOpacity)
    ]
}
