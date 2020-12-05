//
//  TestsHelper.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum TestsHelper {
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    static func isSortedASC(array: [Int]) -> Bool {
        return array == array.sorted()
    }
}
