//
//  AppStoreReviewManager.swift
//  1 Step
//
//  Created by Kai Zheng on 23.12.20.
//

import Foundation
import StoreKit
import Combine

struct AppStoreManager {
    
    static let appStoreURL = "itms-apps://http://itunes.apple.com/app/id\(AppModel.General.appleID)"
    
    
    static func openAppStore() {
        let urlStr = appStoreURL
        UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
    }
    
    
    static func rateApp() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    
    static func askToRateAfterReachingThreeMilestones() {
        guard MainModel.shared.currentScreen.active.isScreen(.goal(.showActive)) else { return }

        if UserDefaultsManager.shared.accomplishmentTotalMilestonesReached >= 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { rateApp() }
        }
    }
    
    
    static var shareAppObserver: AnyCancellable!
    
    static func shareApp() {
        guard let link = URL(string: appStoreURL) else { return }
        let message = "Hi, I just wanted to tell you about a new app. It's called 1 Step."
        let items: [Any] = [link, message]
        
        shareAppObserver = PopupManager.shared.dismissed.sink {
            if $0 == .shareApp {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { rateApp() }
            }
        }
        
        let viewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.completionWithItemsHandler = { (_, completed, _, _) in
            if completed {
                PopupManager.shared.showPopup(.shareApp, backgroundColor: UserColor.user0.standard, hapticFeedback: true) {
                    OneSTextPopupView(titleText: Localized.thankYou, bodyText: "You are awesome!", bottomBtnTitle: "Continue")
                }
                ConfettiManager.shared.showConfetti(amount: .small)
            }
        }

        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
