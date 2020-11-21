//
//  OneSHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

typealias OneSHeaderView = OneSHeaderViewCustom<AnyView>

struct OneSHeaderViewCustom<Content: View>: View {
    
    typealias HeaderButton = (image: HeaderButtonSymbol, color: Color, action: () -> ())
    typealias SecondaryHeaderButton = (image: SecondaryHeaderButtonSymbol, action: () ->())
    
    let titleText: String?
    let leadingButton: HeaderButton?
    let trailingButton: HeaderButton?
    let secondaryButtonOuter: SecondaryHeaderButton?
    let secondaryButtonInner: SecondaryHeaderButton?
    let customView: (() -> Content)?
    
    
    init(_ titleText: String?                           = nil,
         leadingButton: HeaderButton?                   = nil,
         trailingButton: HeaderButton?                  = nil,
         secondaryButtonOuter: SecondaryHeaderButton?   = nil,
         secondaryButtonInner: SecondaryHeaderButton?   = nil,
         customView: (() -> Content)?                   = nil
    ) {
        self.titleText = titleText
        self.leadingButton = leadingButton
        self.trailingButton = trailingButton
        self.secondaryButtonOuter = secondaryButtonOuter
        self.secondaryButtonInner = secondaryButtonInner
        self.customView = customView
    }
    
    
    var body: some View {
        VStack {
            //Buttons
            HStack {
                HeaderButtonView(button: leadingButton)
                Spacer()
                HeaderButtonView(button: trailingButton)
            }
            .padding(.vertical, 16*Layout.multiplierHeight)
            
            //Custom View
            if let customView = customView {
                customView()
            }
            
            //Title + Secondary buttons
            HStack {
                if let titleText = titleText {
                    OneSHeaderText(text: titleText)
                }
                Spacer()
                SecondaryHeaderButtonView(button: secondaryButtonInner)
                SecondaryHeaderButtonView(button: secondaryButtonOuter)
            }
            .padding(.top, 16*Layout.multiplierHeight)
        }
    }
    
    
    private struct HeaderButtonView: View {
        
        let button: HeaderButton?
        
        
        var body: some View {
            if let button = button {
                Group {
                    if button.image.isCustom() {
                        button.image.getCustom()
                            .frame(width: 30, height: 30)
                            .foregroundColor(button.color)
                    } else {
                        button.image.get()
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .colorMultiply(button.color)
                    }
                }
                .onTapGesture { button.action() }
            }
        }
    }
    
    
    private struct SecondaryHeaderButtonView: View {
        
        let button: SecondaryHeaderButton?
        
        
        var body: some View {
            if let button = button {
                OneSSmallBorderButton(symbol: button.image.get(), color: .grayToBackground, action: button.action)
            }
        }
    }
}
