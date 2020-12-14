//
//  ProfileTutorialModel.swift
//  1 Step
//
//  Created by Kai Zheng on 14.12.20.
//

import SwiftUI

class ProfileTutorialModel: ObservableObject {
    
    let color = UserColor.user0.standard
    
    lazy var tutorials: [(title: String, tutorial: OneSTutorialGIF.OneSTutorial)] = [
        (title: Localized.selectMountain,  tutorial: .firstSelectMountain),
        (title: Localized.selectColor,     tutorial: .firstSelectColor),
        (title: Localized.goalBasics,      tutorial: .firstOpenGoal)
    ]
}

    
    
