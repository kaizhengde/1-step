//
//  OneSDropDown.swift
//  1 Step
//
//  Created by Kai Zheng on 19.11.20.
//

import SwiftUI
import Combine

enum OneSDropDownModel {
    static let closeAllExceptSelf = PassthroughSubject<(title: String, art: OneSRowButtonArt), Never>()
}


struct OneSDropDown<Content>: View where Content: View {
    
    @State private var show = false
    
    let rowButtonArt: OneSRowButtonArt
    
    let title: String
    let accessorySFSymbol: Image?
    let accessoryCustomSymbol: Image?
    let accessoryText: String?
    let accessoryColor: Color
    
    let content: () -> Content
    
    
    init(_ rowButtonArt: OneSRowButtonArt,
         title: String,
         accessorySFSymbol: Image?      = nil,
         accessoryCustomSymbol: Image?  = nil,
         accessoryText: String?         = nil,
         accessoryColor: Color          = .grayToBackground,
         content: @escaping () -> Content
    ) {
        self.rowButtonArt = rowButtonArt
        self.title = title
        self.accessorySFSymbol = accessorySFSymbol
        self.accessoryCustomSymbol = accessoryCustomSymbol
        self.accessoryText = accessoryText
        self.accessoryColor = accessoryColor
        self.content = content
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OneSRowButton(rowButtonArt, title: title, accessorySFSymbol: accessorySFSymbol, accessoryCustomSymbol: accessoryCustomSymbol, accessoryText: accessoryText, accessoryColor: accessoryColor) {
                show.toggle()
                if show { OneSDropDownModel.closeAllExceptSelf.send((title, rowButtonArt)) }
            }
            
            if show {
                DropDownContent(show: $show, rowButtonArt: rowButtonArt, content: content)
            }
        }
        .onReceive(OneSDropDownModel.closeAllExceptSelf) { if $0.title != title && $0.art == rowButtonArt { show = false } }
    }
    
    
    private struct DropDownContent: View {
        
        @Binding var show: Bool
        @State private var lineShow = false
        
        let rowButtonArt: OneSRowButtonArt
        let content: () -> Content
        
        
        var body: some View {
            HStack {
                if rowButtonArt == .long {
                    Rectangle()
                        .frame(width: 3)
                        .frame(maxHeight: .infinity)
                        .foregroundColor(.lightNeutralToLightGray)
                        .padding(.leading, Layout.firstLayerPadding)
                        .scaleEffect(x: 1, y: lineShow ? 1 : 0, anchor: .top)
                    
                    Spacer()
                }
                
                content()
                
                if rowButtonArt == .shortBig {
                    Spacer()
                }
            }
            .onReceive(Just(show)) { show in DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { lineShow = show } }
        }
    }
}

