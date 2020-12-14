//
//  ProfileHelpModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class ProfileHelpModel: ObservableObject {
    
    lazy var frequentlyAsked: [(title: String, text: String)] = [
        (title: "How are steps calculated?",
         text: "In short: Depending on the amount of units you choose to take for your goal, each single step has a unique ratio.\n\nLong version:\nInternally, we are distinguishing between stepUnits and steps. StepUnits is equal to what ever the user has chosen for his/her goal.\nSteps on the other way is calculated from the stepUnits with a ratio. This makes sure that independent from your stepUnits, every goal the user creates will have at least ten steps to take and at most thousand."
        ),
        (title: "Can I see statistics for my goals?",
         text: "Soon.\nEvery step you take already saves all necessary information to display statistics.\nHence when the update arrives, your current progress will also be considered and displayed."
        ),
        (title: "Is my data safe?",
         text: "Your data is by default only saved locally on your device.\n\nFor extra safety, you could activate iCloud synchronization inside Data & Privacy.\nThis will automatically synchronize and store all your data inside iCloud as well."
        )
    ]
}
