//
//  TestsHelper.swift
//  1 Step Tests
//
//  Created by Kai Zheng on 21.11.20.
//

import Foundation

enum TestsHelper {
    
    //MARK: - General
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
    
    
    //MARK: - Random generators
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    //MARK: - Other Methods
    
    static func isSortedASC(array: [Int]) -> Bool {
        return array == array.sorted()
    }
    
    
    
}
