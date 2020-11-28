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


fileprivate struct OneSMiniSheet<MiniSheetContent>: ViewModifier where MiniSheetContent: View {
    
    @StateObject private var manager = MiniSheetManager.shared
    @State private var dragOffset: CGFloat = .zero
    
    
    func body(content: Content) -> some View {
        content.overlay(sheet())
    }

    
    func sheet() -> some View {
        ZStack {
            if manager.transition.didAppear {
                Color.opacityBlur.edgesIgnoringSafeArea(.all)
                    .onTapGesture { manager.dismiss() }
            }
            
            if !manager.transition.isFullHidden {
                OneSMiniSheetView()
                    .offset(y: manager.transition.isFullAppeared ? manager.extraHeight : manager.height+2*manager.extraHeight)
                    .offset(y: dragOffset)
                    .gesture(
                        DragGesture()
                        .onChanged { value in
                            if value.translation.height > -manager.extraHeight+12 {
                                dragOffset = value.translation.height
                            }
                        }
                        .onEnded { value in
                            if value.translation.height > 100 {
                                manager.dismiss()
                            }
                            dragOffset = .zero
                        }
                    )
            }
        }
        .oneSAnimation(duration: Animation.Duration.opacity)
    }
    
    
    private struct OneSMiniSheetView: View {
        
        @StateObject private var manager = MiniSheetManager.shared
        
        
        var body: some View {
            VStack {
                Spacer()
                
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.backgroundToGray)
                    
                    VStack {
                        manager.content()
                        Spacer()
                    }
                    .padding(Layout.firstLayerPadding)
                }
                .padding(.vertical, 10)
                .frame(width: Layout.screenWidth, height: manager.height+manager.extraHeight)
                .background(manager.backgroundColor)
                .cornerRadius(12)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
