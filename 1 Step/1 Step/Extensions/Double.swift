//
//  Double.swift
//  1 Step
//
//  Created by Kai Zheng on 27.10.20.
//

import Foundation

extension Double {
    
    func removeTrailingZerosToString() -> String {
        return String(format: "%g", self)
    }
    
    
    func toUI() -> String {
        return String(Double(String(format: "%.2f", self))!.removeTrailingZerosToString())
    }
    
    
    static let almostZero: Double = 0.000000001
}
