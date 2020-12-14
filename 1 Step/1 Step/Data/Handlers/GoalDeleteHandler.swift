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
                titleText:          Localized.delete,
                bodyText:           Localized.GoalChange.confirmDelete,
                textColor:          .backgroundStatic,
                confirmationText:   goal.name,
                placeholder:        goal.name,
                placeholderColor:   .blackStatic,
                inputLimit:         Goal.nameDigitsLimit
            )
        }
    }
}
