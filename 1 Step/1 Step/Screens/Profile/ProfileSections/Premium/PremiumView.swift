//
//  PremiumView.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

struct PremiumView: View {
    
    @StateObject private var fullSheetManager = FullSheetManager.shared
    @StateObject private var viewModel = PremiumModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    Group {
                        OneSHeaderView("Premium", trailingButton: (.close, .grayToBackground, { fullSheetManager.dismiss() }))
                        
                        HStack {
                            OneSSecondaryHeaderText(text: "Achieve every goal", color: UserColor.user0.standard)
                            Spacer()
                        }
                        
                        PremiumFeaturesView(viewModel: viewModel)
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    
                    PremiumMountainView(viewModel: viewModel)
                }
                .padding(.bottom, 80*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct PremiumFeaturesView: View {
        
        @ObservedObject var viewModel: PremiumModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                OneSRowButton(.shortBig, title: "Create unlimited goals") {}
                OneSRowButton(.shortBig, title: "Support future updates") {}
                OneSRowButton(.shortBig, title: "Plant a real tree 🌳", accessorySFSymbol: SFSymbol.info, accessoryColor: .neutralToDarkNeutral) {}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
    private struct PremiumMountainView: View {
        
        @ObservedObject var viewModel: PremiumModel
        @Environment(\.colorScheme) var appearance: ColorScheme
        
        var mountainPremium: Image { appearance == .light ? MountainImage.Premium.currentLight : MountainImage.Premium.currentDark }
        
        
        var body: some View {
            ZStack(alignment: .top) {
                Color.darkBackgroundToDarkGray
                    .frame(width: Layout.screenWidth)
                    .frame(maxHeight: .infinity)
                    .offset(y: MountainLayout.premiumHeight)
                
                mountainPremium
                    .resizable()
                    .frame(width: Layout.screenWidth, height: MountainLayout.premiumHeight)
                    .aspectRatio(contentMode: .fit)
                
                MountainContentView(viewModel: viewModel)
                    .padding(.top, MountainLayout.premiumHeight-100*Layout.multiplierWidth)
                    .padding(.horizontal, Layout.firstLayerPadding)
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 20)
        }
        
        
        private struct MountainContentView: View {
            
            @ObservedObject var viewModel: PremiumModel
            
            
            var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    OneSText(text: "You choose the price", font: .custom(.bold, 24), color: .grayToBackground)
                    
                    HStack(spacing: 12) {
                        PremiumItem(price: "€ 7.99", backgroundColor: UserColor.user1.standard)
                        PremiumItem(price: "€ 10.49", backgroundColor: UserColor.user0.standard)
                    }
                    .padding(.bottom, 40)
                    
                    Group {
                        OneSText(text: "Note", font: .custom(.bold, 20), color: .grayToBackground)
                        
                        OneSMultilineText(text: "This purchase will give you access to all current and future functionality. No subscription, you only pay once and it’s forever yours.")
                    }
                    
                    OneSRowButton(.shortBig, title: "Restore purchase") {}
                        .padding(.top, 20)
                    
                    HStack(spacing: 40) {
                        OneSText(text: "Privacy policy", font: .custom(.semiBold, 13), color: UserColor.user0.standard)
                        OneSText(text: "Terms of use", font: .custom(.semiBold, 13), color: UserColor.user0.standard)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            private struct PremiumItem: View {
                
                let price: String
                let backgroundColor: Color
                
                
                var body: some View {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                OneSText(text: "Lifetime", font: .custom(.semiBold, 21), color: .whiteToDarkGray)
                                OneSText(text: "PREMIUM", font: .custom(.extraBold, 10), color: .whiteToDarkGray)
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        
                        OneSText(text: price, font: .custom(.extraBold, 28), color: .whiteToDarkGray)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140*Layout.multiplierWidth)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .oneSShadow(opacity: 0.1, y: 2, blur: 10)
                    .oneSItemTapScale()
                    .oneSItemTransition()
                }
            }
        }
    }
}
