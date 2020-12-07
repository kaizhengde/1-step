//
//  AppModel.swift
//  1 Step
//
//  Created by Kai Zheng on 04.12.20.
//

import SwiftUI

final class AppModel {
    
    static let version = "1.0"
    
    
    static func setAppIcon(with name: String?) {
        if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
            
            typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
            
            let selectorString = "_setAlternateIconName:completionHandler:"
            
            let selector = NSSelectorFromString(selectorString)
            let imp = UIApplication.shared.method(for: selector)
            let method = unsafeBitCast(imp, to: setAlternateIconName.self)
            method(UIApplication.shared, selector, name as NSString?, { _ in })
        }
    }
}
