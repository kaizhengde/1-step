//
//  OneSSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct OneSSectionView<Content: View>: View {
    
    let title: String
    let titleColor: Color
    let content: () -> Content
    
    init(title: String, titleColor: Color = .grayToBackground, content: @escaping () -> Content) {
        self.title = title
        self.titleColor = titleColor
        self.content = content
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                OneSText(text: title, font: .custom(.semiBold, 16), color: titleColor)
                Spacer()
            }
            content()
        }
    }
}
