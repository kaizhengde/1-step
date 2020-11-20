//
//  OneSDropDown.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI

enum OneSDropDownArt {
    
    case long, short
}

struct OneSDropDown<Content>: View where Content: View {
    
    @State private var show = false
    
    let dropDownArt: OneSDropDownArt
    
    let title: String
    let accessorySFSymbol: Image?
    let accessoryCustomSymbol: Image?
    
    let content: () -> Content
    
    
    init(_ dropDownArt: OneSDropDownArt, title: String, accessorySFSymbol: Image? = nil, accessoryCustomSymbol: Image? = nil, content: @escaping () -> Content) {
        self.dropDownArt = dropDownArt
        self.title = title
        self.accessorySFSymbol = accessorySFSymbol
        self.accessoryCustomSymbol = accessoryCustomSymbol
        self.content = content
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OneSRowButton(dropDownArt == .long ? .long : .shortBig, title: title, accessorySFSymbol: accessorySFSymbol, accessoryCustomSymbol: accessoryCustomSymbol) { show.toggle() }
            
            if show {
                DropDownContent(dropDownArt: dropDownArt, content: content)
            }
        }
        .frame(width: Layout.firstLayerWidth, alignment: .leading)
    }
    
    
    private struct DropDownContent: View {
        
        let dropDownArt: OneSDropDownArt
        let content: () -> Content
        
        
        var body: some View {
            HStack {
                if dropDownArt == .long {
                    Rectangle()
                        .frame(width: 3)
                        .frame(maxHeight: .infinity)
                        .foregroundColor(.lightNeutralToLightGray)
                        .padding(.leading, Layout.firstLayerPadding)
                    
                    Spacer()
                }
                
                content()
                
                if dropDownArt == .short {
                    Spacer()
                }
            }
        }
    }
}

