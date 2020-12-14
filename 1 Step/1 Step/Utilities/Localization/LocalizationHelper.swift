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


enum LocalizationHelper {
    
    static func languageDescription(of languageKey: String) -> String {
        if languageKey.contains("en") { return Localized.english }
        if languageKey.contains("de") { return Localized.german }
        
        return "Unknown"
    }
}


