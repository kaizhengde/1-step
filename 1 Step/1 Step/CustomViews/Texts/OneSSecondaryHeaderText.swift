//
//  OneSSecondaryHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 09.10.20.
//

import SwiftUI

struct OneSSecondaryHeaderText: View {
    
    let text: String
    let color: Color
    
    
    var body: some View {
        Text(text)
            .font(OneSFont.header2.font)
            .foregroundColor(color)
    }
}
