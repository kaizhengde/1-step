//
//  OneSTextFloater.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextFloater: View {
    
    @StateObject private var manager = FloaterManager.shared
    
    
    var body: some View {
        OneSText(text: manager.bodyText, font: .footnote, color: .backgroundToGray)
    }
}
