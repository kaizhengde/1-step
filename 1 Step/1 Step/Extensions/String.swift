//
//  String.swift
//  1 Step
//
//  Created by Kai Zheng on 24.11.20.
//

import SwiftUI

extension String {

    func removeWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    
    func addHyphens() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0

        let hyphenAttribute = [
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
        ] as [NSAttributedString.Key : Any]

        let attributedString = NSMutableAttributedString(string: self, attributes: hyphenAttribute)
        
        print(attributedString)
        return attributedString
    }
}
