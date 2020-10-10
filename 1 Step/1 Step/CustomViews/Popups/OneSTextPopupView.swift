//
//  OneSTextPopup.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSTextPopupView: View {

    let bodyText: String
    
    
    var body: some View {
        OneSText(text: bodyText, font: .body2, color: .backgroundToGray)
    }
}
