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
    let secondaryButtonBottom: SecondaryHeaderButton?    
    let secondaryButtonTop: SecondaryHeaderButton?
    let isInsideSheet: Bool
    let customView: (() -> Content)?                    
    
    
    init(_ titleText: String?                           = nil,
         leadingButton: HeaderButton?                   = nil,
         trailingButton: HeaderButton?                  = nil,
         secondaryButtonTop: SecondaryHeaderButton?     = nil,
         secondaryButtonBottom: SecondaryHeaderButton?  = nil,
         isInsideSheet: Bool                            = false,
         customView: (() -> Content)?                   = nil
    ) {
        self.titleText              = titleText
        self.leadingButton          = leadingButton
        self.trailingButton         = trailingButton
        self.secondaryButtonTop     = secondaryButtonTop
        self.secondaryButtonBottom  = secondaryButtonBottom
        self.isInsideSheet          = isInsideSheet
        self.customView             = customView
    }
    
    
    var body: some View {
        VStack {
            //Buttons
            HStack {
                HeaderButtonView(button: leadingButton)
                Spacer()
                HeaderButtonView(button: trailingButton)
            }
            .padding(.vertical, 16*Layout.multiplierWidth)
            
            //Custom View
            if let customView = customView {
                customView()
            }
            
            //Title + Secondary buttons
            HStack(alignment: .titleSecondaryButtonAlignment) {
                if let titleText = titleText {
                    OneSHeaderText(text: titleText)
                        .alignmentGuide(.titleSecondaryButtonAlignment) { $0[VerticalAlignment.center] }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    SecondaryHeaderButtonView(button: secondaryButtonTop)
                        .alignmentGuide(.titleSecondaryButtonAlignment) { $0[VerticalAlignment.center] }
                    SecondaryHeaderButtonView(button: secondaryButtonBottom)
                }
            }
            .padding(.top, 16*Layout.multiplierWidth)
        }
        .padding(.top, 12 + Layout.onlyOniPhoneXType(-12))
        .padding(.top, isInsideSheet ? Layout.sheetTopPadding : 0)
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


extension VerticalAlignment {
    
    enum TitleSecondaryButtonAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    
    static let titleSecondaryButtonAlignment = Self(TitleSecondaryButtonAlignment.self)
}
