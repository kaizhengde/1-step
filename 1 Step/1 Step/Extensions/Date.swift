//
//  Date.swift
//  1 Step
//
//  Created by Kai Zheng on 18.11.20.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
