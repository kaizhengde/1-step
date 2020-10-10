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
    @State private var dragOffset: CGFloat = .zero
    
    
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
                    .offset(y: miniSheetManager.transition.isFullAppeared ? miniSheetManager.extraHeight : miniSheetManager.height+miniSheetManager.extraHeight)
                    .offset(y: dragOffset)
                    .gesture(
                        DragGesture()
                        .onChanged { value in
                            if value.translation.height > -miniSheetManager.extraHeight+12 {
                                dragOffset = value.translation.height
                            }
                        }
                        .onEnded { value in
                            if value.translation.height > 100 {
                                miniSheetManager.dismiss()
                            }
                            dragOffset = .zero
                        }
                    )
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
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.backgroundToGray)
                    
                    VStack {
                        HStack {
                            OneSSecondaryHeaderText(text: miniSheetManager.titleText, color: .backgroundToGray)
                            Spacer()
                            OneSContinueButton(color: .backgroundToGray, withScale: false) { miniSheetManager.dismiss() }
                        }
                        .padding(.bottom, 20)
                        
                        miniSheetManager.content()
                        Spacer()
                    }
                    .padding(Layout.firstLayerPadding)
                }
                .padding(.vertical, 10)
                .frame(width: Layout.screenWidth, height: miniSheetManager.height+miniSheetManager.extraHeight)
                .background(miniSheetManager.backgroundColor)
                .cornerRadius(12)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
