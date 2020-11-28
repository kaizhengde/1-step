//
//  OneSAuthorizationStatus.swift
//  1 Step
//
//  Created by Kai Zheng on 28.11.20.
//

import SwiftUI

enum OneSAuthorizationStatus: String, Codable {
    case none, granted, rejected
}

extension OneSAuthorizationStatus: UserDefaultType {}
extension UNAuthorizationStatus: Codable, UserDefaultType {}
