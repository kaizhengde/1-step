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
        if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
            
            typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
            
            let selectorString = "_setAlternateIconName:completionHandler:"
            
            let selector = NSSelectorFromString(selectorString)
            let imp = UIApplication.shared.method(for: selector)
            let method = unsafeBitCast(imp, to: setAlternateIconName.self)
            method(UIApplication.shared, selector, name as NSString?, { _ in })
            
            print("App Icon updated!")
        }
    }
    
    
    static func updateAppIconAppearance(with appearance: ColorScheme, themeChange: Bool = false) {
        let colorTheme = UserDefaultsManager.shared.settingColorTheme
        
        let update = {
            if appearance == .light {
                AppModel.setAppIcon(with: colorTheme.appIcon.light)
            }
            else {
                AppModel.setAppIcon(with: colorTheme.appIcon.dark)
            }
        }
                
        if UserDefaultsManager.shared.settingAppearance == .mirrorDevice && !themeChange {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { update() }
        } else { update() }
    }
}
