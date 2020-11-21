//
//  OneSSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct OneSSectionView<Content: View>: View {
    
    let title: String
    let content: () -> Content
    
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                OneSText(text: title, font: .custom(weight: Raleway.semiBold, size: 16), color: .grayToBackground)
                Spacer()
            }
            content()
        }
    }
}
