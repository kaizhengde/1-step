//
//  PremiumProduct.swift
//  1 Step
//
//  Created by Kai Zheng on 21.12.20.
//

import SwiftUI
import StoreKit

struct PremiumProduct: Hashable {
    
    let id: String
    let product: SKProduct
    let locale: Locale
    var price: String?
    
    
    init(product: SKProduct) {
        self.id         = product.productIdentifier
        self.product    = product
        self.locale     = product.priceLocale
        self.price      = priceFormatter.string(from: product.price)
    }
    
    
    private lazy var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter
    }()
}


struct PremiumProductItem {
    
    var product: PremiumProduct?
    let color: Color 
}
