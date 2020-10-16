//
//  OneSHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

typealias OneSHeaderView = OneSHeaderViewCustom<EmptyView>

struct OneSHeaderViewCustom<Content: View>: View {
    
    typealias HeaderButton = (image: HeaderButtonSymbol, color: Color, action: () -> ())
    
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
                CustomButton(button: leadingButton)
                Spacer()
                CustomButton(button: trailingButton)
            }
            .padding(.vertical, 16*Layout.multiplierHeight)
            
            //Custom View
            if let customView = customView {
                customView()
            }
            
            //Title
            if let titleText = titleText {
                HStack {
                    OneSHeaderText(text: titleText)
                    Spacer()
                }
                .padding(.top, 16*Layout.multiplierHeight)
            }
        }
    }
    
    
    private struct CustomButton: View {
        
        let button: HeaderButton?
        
        
        var body: some View {
            if let button = button {
                if button.image.isCustom() {
                    button.image.getCustom()
                        .frame(width: 30, height: 30)
                        .foregroundColor(button.color)
                        .onTapGesture { button.action() }
                } else {
                    button.image.get()
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .colorMultiply(button.color)
                        .onTapGesture { button.action() }
                }
            }
        }
    }
}
