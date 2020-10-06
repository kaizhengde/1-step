//
//  OneSHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct OneSHeaderView<Content: View>: View {
    
    let leadingButton: (image: Image, color: Color, action: () -> ())? = nil
    let trailingButton: (image: Image, color: Color, action: () -> ())? = nil
    let customView: (() -> Content)? = nil
    let titleText: String? = nil
    
    
    var body: some View {
        VStack {
            //Buttons
            HStack {
                Button(button: leadingButton)
                Spacer()
                Button(button: trailingButton)
            }
            
            //Custom View
            if let customView = customView {
                customView()
            }
            
            //Title
            if let titleText = titleText {
                HStack {
                    Text(titleText)
                        .font(.custom(Raleway.extraBold, size: 40))
                    Spacer()
                }
            }
        }
        .padding(.horizontal, Layout.firstLayerPadding)
    }
    
    
    private struct Button: View {
        
        let button: (image: Image, color: Color, action: () -> ())?
        
        
        var body: some View {
            
            if let button = button {
                button.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
                    .colorMultiply(button.color)
                    .onTapGesture { button.action() }
            }
        }
    }
}
