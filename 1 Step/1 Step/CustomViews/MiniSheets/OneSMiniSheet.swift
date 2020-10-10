//
//  OneSMiniSheet.swift
//  1 Step
//
//  Created by Kai Zheng on 10.10.20.
//

import SwiftUI

extension View {

    func oneSMiniSheet() -> some View {
        self.modifier(OneSMiniSheet<AnyView>())
    }
}


struct OneSMiniSheet<MiniSheetContent>: ViewModifier where MiniSheetContent: View {
    
    @StateObject private var miniSheetManager = MiniSheetManager.shared
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if miniSheetManager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
                    .onTapGesture { miniSheetManager.dismiss() }
            }
            
            if !miniSheetManager.transition.isFullHidden {
                OneSMiniSheetView()
                    .opacity(miniSheetManager.transition.isFullAppeared ? 1.0 : 0.0)
                    .offset(y: miniSheetManager.transition.isFullAppeared ? miniSheetManager.cornerRadius : miniSheetManager.height+miniSheetManager.cornerRadius)
            }
        }
        .oneSAnimation(duration: AnimationDuration.opacity)
    }
    
    
    private struct OneSMiniSheetView: View {
        
        @StateObject private var miniSheetManager = MiniSheetManager.shared
        
        
        var body: some View {
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        OneSSecondaryHeaderText(text: miniSheetManager.titleText, color: .backgroundToGray)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    miniSheetManager.content()
                    
                    Spacer()
                }
                .padding(Layout.firstLayerPadding)
                .padding(.vertical, 10)
                .frame(width: Layout.screenWidth, height: miniSheetManager.height+miniSheetManager.cornerRadius)
                .background(miniSheetManager.backgroundColor)
                .cornerRadius(miniSheetManager.cornerRadius)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
