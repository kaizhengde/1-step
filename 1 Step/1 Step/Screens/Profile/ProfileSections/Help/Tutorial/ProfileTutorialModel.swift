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
        (title: "Select mountain",  tutorial: .firstSelectMountain),
        (title: "Select color",     tutorial: .firstSelectColor),
        (title: "Goal basics",      tutorial: .firstOpenGoal)
    ]
}

    
    
