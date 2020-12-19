//
//  CloudKitHandler.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import SwiftUI
import CloudKit
import Combine

enum CloudKitHandler {
    
    static let finished = PassthroughSubject<Void, Never>()
    
    static func cloudKitButtonToggled() {
        let isOn = UserDefaultsManager.shared.settingICloudSynch
        
        if !isOn {
            LoadingViewManager.shared.showLoadingView(wheelColor: UserColor.user0.standard)
            
            CKContainer.default().accountStatus { (accountStatus, error) in
                DispatchQueue.main.async {
                    if case .available = accountStatus {
                        checkForInternetConnection {
                            UserDefaultsManager.shared.settingICloudSynch.toggle()
                            PersistenceManager.defaults.updateContainer()
                            UserDefaultsManager.shared.syncAllICloudDefaults()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                LoadingViewManager.shared.dismiss()
                                finished.send()
                            }
                        }
                    } else {
                        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                            OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Error.iCloudNotAvailable)
                        }
                        
                        LoadingViewManager.shared.dismiss()
                    }
                }
            }
        } else {
            UserDefaultsManager.shared.settingICloudSynch.toggle()
            PersistenceManager.defaults.updateContainer()
            finished.send()
        }
    }
    
    
    private static func checkForInternetConnection(success: @escaping () -> ()) {
        NetworkManager.startNotifier()
        
        NetworkManager.isUnreachable { _ in
            PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Error.noInternetConnection)
            }
            
            LoadingViewManager.shared.dismiss()
            NetworkManager.stopNotifier()
        }
        
        NetworkManager.isReachable { _ in
            success()
        }
    }
}
