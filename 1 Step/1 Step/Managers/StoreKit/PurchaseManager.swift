//
//  PurchaseManager.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import SwiftUI
import StoreKit
import Combine

final class PurchaseManager: NSObject, ObservableObject {
        
    private let productIdentifiers = Set([
        "com.kaizheng.1_Step.premium_1",
        "com.kaizheng.1_Step.premium_2"
    ])
    
    @Published var premiumProducts = [PremiumProduct]()
    let purchaseSuccessful = PassthroughSubject<PremiumProduct, Never>()
    
    
    override init() {
        super.init()
        fetchProducts()
    }
    
    var request: SKProductsRequest?
    
    
    private func fetchProducts() {
        request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request?.delegate = self
        request?.start()
    }
    
    
    func purchase(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    func restore() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    private func getPremiumProduct(from identifier: String) -> PremiumProduct {
        return premiumProducts.first(where: { $0.id == identifier })!
    }
}


extension PurchaseManager: SKProductsRequestDelegate {
    
    //Fetch all purchasable options (products)
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        let invalidProducts = response.invalidProductIdentifiers
                
        guard !loadedProducts.isEmpty else {
            print("Could not load the products.")
            
            if !invalidProducts.isEmpty {
                print("Invalid Products found: \(invalidProducts)")
            }
            
            PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                OneSTextPopupView(titleText: Localized.error, bodyText: Localized.unknownError)
            }
            
            return
        }
        
        DispatchQueue.main.async {
            loadedProducts.forEach {
                self.premiumProducts.append(PremiumProduct(product: $0))
            }
            self.objectWillChange.send()
            self.request = nil
        }
    }
}


extension PurchaseManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple")
        
        for transaction in transactions {
            let productID = transaction.payment.productIdentifier
            
            switch transaction.transactionState {
            case .purchasing, .deferred:
                if productID.contains("1") {
                    FirebaseAnalyticsEvent.Premium.purchasingPremium1()
                } else {
                    FirebaseAnalyticsEvent.Premium.purchasingPremium2()
                }
                                
            case .purchased:
                purchaseSuccessful.send(getPremiumProduct(from: productID))
                
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                
                if productID.contains("1") {
                    FirebaseAnalyticsEvent.Premium.purchasedPremium1()
                } else {
                    FirebaseAnalyticsEvent.Premium.purchasedPremium2()
                }
                print("Purchased: \(productID)")
                
            case .restored:
                purchaseSuccessful.send(getPremiumProduct(from: productID))
                
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                
                FirebaseAnalyticsEvent.Premium.refundSuccessful()
                print("Restored: \(productID)")
                
            case .failed:
                OneSFeedback.failed()
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                
                if productID.contains("1") {
                    FirebaseAnalyticsEvent.Premium.canceledPremium1()
                } else {
                    FirebaseAnalyticsEvent.Premium.canceledPremium2()
                }
                print("Failed: \(productID)")
            
            @unknown default: break
            }
        }
    }
    
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        let transactionCount = queue.transactions.count
        if transactionCount == 0 {
            OneSFeedback.failed()
            FirebaseAnalyticsEvent.Premium.refundFailed()
        }
    }

    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
            OneSTextPopupView(titleText: Localized.error, bodyText: error.localizedDescription)
        }
    }
}
