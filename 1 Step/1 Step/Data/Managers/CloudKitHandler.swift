//
//  CloudKitHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import SwiftUI
import CloudKit

enum CloudKitHandler {
    
    static func cloudKitButtonToggled() {
        let isOn = UserDefaultsManager.shared.settingICloudSynch
        
        if !isOn {
            LoadingViewManager.shared.showLoadingView(wheelColor: UserColor.user0.standard)
            
            CKContainer.default().accountStatus { (accountStatus, error) in
                DispatchQueue.main.async {
                    if case .available = accountStatus {
                        UserDefaultsManager.shared.settingICloudSynch.toggle()
                        PersistenceManager.defaults.updateContainer()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            LoadingViewManager.shared.dismiss()
                        }
                    } else {
                        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                            OneSTextPopupView(titleText: "Error", bodyText: "Make sure that you have an active internet connection and iCloud turned on for 1 Step inside your device settings.")
                        }
                        
                        LoadingViewManager.shared.dismiss()
                    }
                }
            }
        } else {
            UserDefaultsManager.shared.settingICloudSynch.toggle()
            PersistenceManager.defaults.updateContainer()
        }
    }
}
