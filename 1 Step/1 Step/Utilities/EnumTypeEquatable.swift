//
//  EnumTypeEquatable.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import Foundation

protocol EnumTypeEquatable {
    static func ~=(lhs: Self, rhs: Self) -> Bool
}
