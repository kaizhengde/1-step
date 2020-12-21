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
    
    @Published var purchaseManager = PurchaseManager()
    var cancellable: AnyCancellable?
    
    var premiumItems: [PremiumProductItem] {
        var items = Array<PremiumProductItem>(repeating: PremiumProductItem(product: nil, color: .neutralToDarkNeutral), count: 2)
        
        if !purchaseManager.premiumProducts.isEmpty {
            items[0] = PremiumProductItem(product: purchaseManager.premiumProducts[0], color: UserColor.user0.standard)
            items[1] = PremiumProductItem(product: purchaseManager.premiumProducts[1], color: UserColor.user1.standard)
        }
        
        return items
    }
    
    @Published var changeRow: (first: Bool, second: Bool, third: Bool) = (false, false ,false)
    let scrollToTop = PassthroughSubject<Void, Never>()
       
    
    init() {
        cancellable = purchaseManager.objectWillChange.sink { [weak self] in
            self?.objectWillChange.send()
        }
        
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
    
    func premiumItemTapped(with item: PremiumProductItem) {
        OneSFeedback.light()
        
        guard let product = item.product else { return }
        guard !purchased else {
            ConfettiManager.shared.showConfetti(amount: .small)
            return
        }
        
        purchaseManager.purchase(product: product.product)
    }
    
    
    func finishPurchase(with product: PremiumProduct) {
        scrollToTop.send()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UserDefaultsManager.shared.settingPremium = true
            
            self.changeRow.first = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { self.changeRow.second = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.changeRow.third = true }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                let item = self.premiumItems.first(where: { $0.product == product })!
                
                PopupManager.shared.showPopup(.premiumPurchased, backgroundColor: item.color, height: 400*Layout.multiplierWidth, dismissOnTapOutside: false) {
                    OneSTextPopupView(
                        titleText: Localized.thankYou,
                        bodyText: "\(UserDefaultsManager.shared.userName), \(Localized.Premium.thankYouText)",
                        bottomBtnTitle: Localized.start
                    )
                }
                
                OneSFeedback.achievement()
                ConfettiManager.shared.showConfetti(amount: .big)
            }
        }
    }
}
