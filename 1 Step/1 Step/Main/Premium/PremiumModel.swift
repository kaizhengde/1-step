//
//  PremiumModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI
import Combine

final class PremiumModel: ObservableObject {
    
    var purchased: Bool { UserDefaultsManager.shared.settingPremium }
    let scrollToTop = PassthroughSubject<Void, Never>()
    
    @Published var changeRow: (first: Bool, second: Bool, third: Bool) = (false, false ,false)
    
    
    init() {
        if purchased {
            changeRow = (true, true ,true)
        }
    }
    
    
    func dismiss(with key: PopupKey) {
        if key == .premiumPurchased {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { FullSheetManager.shared.dismiss() }
        }
    }
    
    
    //MARK: - Premium Feature Rows
    
    func premiumFeatureRowBackgroundColor(with changeRow: Bool) -> Color {
        changeRow ? UserColor.user0.standard : .whiteToDarkGray
    }
    
    
    func premiumFeatureRowTextColor(with changeRow: Bool) -> Color {
        changeRow ? .backgroundToGray : .grayToBackground
    }
    
    
    func premiumFeatureRowAccessoryColor(with changeRow: Bool) -> Color {
        changeRow ? .backgroundToGray : .neutralToDarkNeutral
    }
    
    
    //MARK: - Premium Item
    
    typealias PremiumItemData = (price: String, color: Color)
    
    let firstPremiumItem: PremiumItemData  = ("€ 7.99", UserColor.user1.standard)
    let secondPremiumItem: PremiumItemData = ("€ 10.49", UserColor.user0.standard)
    
    
    func premiumItemTapped(with item: PremiumItemData) {
        guard !purchased else {
            ConfettiManager.shared.showConfetti(amount: .small)
            return
        }
     
        scrollToTop.send()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UserDefaultsManager.shared.settingPremium = true
            
            self.changeRow.first = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { self.changeRow.second = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.changeRow.third = true }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                PopupManager.shared.showPopup(.premiumPurchased, backgroundColor: item.color, height: 400*Layout.multiplierWidth, dismissOnTapOutside: false) {
                    OneSTextPopupView(
                        titleText: "Thank you",
                        bodyText: "\(UserDefaultsManager.shared.userName), this is our gratitude towards you.\n\nWe wish you a wonderful experience with 1 Step Premium.",
                        bottomBtnTitle: "START"
                    )
                }
                
                OneSFeedback.achievement()
                ConfettiManager.shared.showConfetti(amount: .big)
            }
        }
    }
}
