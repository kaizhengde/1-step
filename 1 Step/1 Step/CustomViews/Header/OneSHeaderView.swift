//
//  OneSHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

typealias OneSHeaderView = OneSHeaderViewCustom<EmptyView>

struct OneSHeaderViewCustom<Content: View>: View {
    
    typealias HeaderButton = (image: HeaderButtonImage, color: Color, action: () -> ())
    
    let titleText: String?
    let leadingButton: HeaderButton?
    let trailingButton: HeaderButton?
    let customView: (() -> Content)?
    
    
    init(_ titleText: String? = nil, leadingButton: HeaderButton? = nil, trailingButton: HeaderButton? = nil, customView: (() -> Content)? = nil) {
        self.titleText = titleText
        self.leadingButton = leadingButton
        self.trailingButton = trailingButton
        self.customView = customView
    }
    
    
    var body: some View {
        VStack {
            //Buttons
            HStack {
                Button(button: leadingButton)
                Spacer()
                Button(button: trailingButton)
            }
            .padding(.vertical, 16)
            
            //Custom View
            if let customView = customView {
                customView()
            }
            
            //Title
            if let titleText = titleText {
                HStack {
                    OneSHeaderTextView(text: titleText)
                    Spacer()
                }
                .padding(.top, 16)
            }
        }
    }
    
    
    private struct Button: View {
        
        let button: HeaderButton?
        
        
        var body: some View {
            if let button = button {
                button.image.get()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .colorMultiply(button.color)
                    .onTapGesture { button.action() }
            }
        }
    }
}
