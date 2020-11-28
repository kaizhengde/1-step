//
//  LocalizationHelper.swift
//  1 Step
//
//  Created by Kai Zheng on 24.11.20.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}


