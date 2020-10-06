//
//  OneSHeaderTextView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct OneSHeaderTextView: View {
    
    let text: String
    
    
    var body: some View {
        Text(text)
            .font(OneSFont.header2.get())
            .foregroundColor(.grayToBackground)
    }
}

