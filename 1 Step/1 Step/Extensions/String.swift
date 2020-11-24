//
//  String.swift
//  1 Step
//
//  Created by Kai Zheng on 24.11.20.
//

import Foundation

extension String {

    func removeWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
