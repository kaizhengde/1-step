//
//  OneSAccomplishment.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import Foundation

@propertyWrapper
struct OneSAccomplishment {
    var value: Int
    
    init(wrappedValue: Int) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Int {
        get { value }
        set { value = min(0, newValue) }
    }
}
