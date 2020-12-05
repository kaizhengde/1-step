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
    
    
    func oneSRounded(to place: Int = 2) -> Double {
        return Double(String(format: "%.\(place)f", self))!
    }
    
    
    mutating func oneSRound(to place: Int = 2) {
        self = Double(String(format: "%.\(place)f", self))!
    }
    
    
    static let almostZero: Double = 0.000000001
}
