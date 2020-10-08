//
//  OneSTextView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct OneSTextView: View {
    
    let text: String
    let font: OneSFont
    let color: Color
    
    
    var body: some View {
        Text(text)
            .font(font.get())
            .foregroundColor(color)
    }
}



