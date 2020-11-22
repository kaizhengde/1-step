//
//  UserDefaultType.swift
//  1 Step
//
//  Created by Kai Zheng on 22.11.20.
//

import Foundation

protocol UserDefaultType {}

extension Data: UserDefaultType {}
extension String: UserDefaultType {}
extension Date: UserDefaultType {}
extension Bool: UserDefaultType {}
extension Int: UserDefaultType {}
extension Double: UserDefaultType {}
extension Float: UserDefaultType {}

extension Array: UserDefaultType where Element: UserDefaultType {}
extension Dictionary: UserDefaultType where Key == String, Value: UserDefaultType {}
