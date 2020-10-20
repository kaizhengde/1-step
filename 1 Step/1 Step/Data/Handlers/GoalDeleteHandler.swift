//
//  GoalDeleteHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import Foundation

struct GoalDeleteHandler {
    
    static func confirmDelete(with goal: Goal) {
        PopupManager.shared.showTextFieldConfirmationPopup(titleText: "Delete", bodyText: "Are you sure?\n\nThis action cannot be undone.\nConfirm with your Goal.", placerholder: "Your Goal", textLimit: Goal.nameDigitsLimit, confirmationText: goal.name, backgroundColor: .grayToBackground)
    }
}
