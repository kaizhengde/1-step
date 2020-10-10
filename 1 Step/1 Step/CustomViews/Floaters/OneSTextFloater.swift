//
//  OneSTextFloater.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextFloater: View {
    
    let bodyText: String
    
    
    var body: some View {
        OneSText(text: bodyText, font: .footnote, color: .backgroundToGray)
    }
}
