//
//  ProfileHelpModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class ProfileHelpModel: ObservableObject {
    
    lazy var frequentlyAsked: [(title: String, text: String)] = [
        (title: Localized.Help.question1_title, text: Localized.Help.question1_text),
        (title: Localized.Help.question2_title, text: Localized.Help.question2_text),
        (title: Localized.Help.question3_title, text: Localized.Help.question3_text),
        (title: Localized.Help.question4_title, text: Localized.Help.question4_text),
        (title: Localized.Help.question5_title, text: Localized.Help.question5_text),
        (title: Localized.Help.question6_title, text: Localized.Help.question6_text)
    ]
}
