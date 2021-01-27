//
//  AppModel.swift
//  1 Step
//
//  Created by Kai Zheng on 04.12.20.
//

import SwiftUI

enum AppModel {
    
    enum General {
        
        static let appleID = "1542645142"
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    
    //MARK: - AppIcon
    
    static func setAppIcon(with name: String?) {
        UIApplication.shared.setAlternateIconName(name)
    }
}
