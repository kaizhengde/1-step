//
//  ProfileHelpModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class ProfileHelpModel: ObservableObject {
    
    lazy var frequentlyAsked: [(title: String, text: String)] = [
        (title: "Can I redo my steps?",
         text: "Yes, but not directly. You would have to take the same amount of negative steps.\nNegative steps are on the top of the wheel you use to add steps.\nBy scrolling all the way to the top, I am sure you will find them."
        ),
        (title: "Can I reset my goal?",
         text: "It is not possible to reset a goal immediately.\nYou would have to delete your goal and create it again."
        ),
        (title: "Can I change the order of my goals?",
         text: "Sure. You can change the order of active and reached goals by long pressing on any goal item.\nThis will activate drag and drop."
        ),
        (title: "How can I delete a reached goal?",
         text: "A delete button is placed at the bottom of the mountain.\nYou would have to scroll all the way down to see it."
        ),
        (title: "How are steps calculated?",
         text: "In short: Depending on the amount of units you choose to take for your goal (plant 30 trees -> 30), each single step has a unique ratio.\n\nLong version:\nInternally, we are distinguishing between stepUnits and steps. StepUnits are equal to what ever the user has chosen for his/her goal.\nSteps on the other hand, are calculated from stepUnits with a specific ratio. This makes sure that independent from your stepUnits, every goal you create will have at least ten steps to take and at most thousand.\n\nExample:\nMeditate 3 hours.\nThis goal would have a ratio of 60, leading to 180 steps to take in total.\nEach step would correspond to 1 minute."
        ),
        (title: "Are there any statistics of my progress besides accomplishments?",
         text: "Soon.\nEvery step you take already saves all necessary information to display statistics.\nHence when the update arrives, your current progress will also be considered and displayed."
        ),
        (title: "Is my data safe?",
         text: "Your data is by default only saved locally on your device.\n\nFor extra safety, you could activate iCloud synchronization inside Data & Privacy.\nThis will automatically synchronize and store all your data inside iCloud as well."
        )
    ]
}
