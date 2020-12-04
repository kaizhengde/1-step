//
//  GoalDeleteHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 20.10.20.
//

import Foundation

struct GoalDeleteHandler {
    
    static func confirmDelete(with goal: Goal) {
        PopupManager.shared.showPopup(.goalDelete, backgroundColor: .grayStatic, height: 400*Layout.multiplierWidth, hapticFeedback: true) {
            OneSTextFieldConfirmationPopupView(
                titleText: "Delete",
                bodyText: "Are you sure?\n\nThis action cannot be undone.\nConfirm with your Goal.",
                textColor: .backgroundStatic,
                confirmationText: goal.name,
                placeholder: goal.name,
                placeholderColor: .blackStatic,
                inputLimit: Goal.nameDigitsLimit
            )
        }
    }
}
