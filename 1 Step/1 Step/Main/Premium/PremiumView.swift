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
                ScrollViewReader { scrollProxy in
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 0).id(0)
                        
                        VStack(spacing: 32) {
                            Group {
                                OneSHeaderView(Localized.premium, trailingButton: (.close, .grayToBackground, { fullSheetManager.dismiss() }))
                                
                                HStack {
                                    OneSSecondaryHeaderText(text: Localized.Premium.achieveEveryGoal, color: UserColor.user0.standard)
                                    Spacer()
                                }
                                
                                PremiumFeaturesView(viewModel: viewModel)
                            }
                            .padding(.horizontal, Layout.firstLayerPadding)
                            
                            PremiumMountainView(viewModel: viewModel)
                        }
                        .padding(.bottom, 80*Layout.multiplierHeight)
                        .onReceive(viewModel.scrollToTop) { withAnimation { scrollProxy.scrollTo(0) } }
                    }
                }
            }
        }
        .oneSAnimation()
        .onReceive(PopupManager.shared.dismissed) { viewModel.dismiss(with: $0) }
        .onReceive(viewModel.purchaseManager.purchaseSuccessful) { viewModel.finishPurchase(with: $0) }
        .onAppear { FirebaseAnalyticsEvent.Premium.openView() }
    }
    
    
    private struct PremiumFeaturesView: View {
        
        @ObservedObject var viewModel: PremiumModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                OneSRowButton(
                    .shortBig,
                    title:              Localized.Premium.unlimitedGoals,
                    textColor:          viewModel.premiumFeatureRowTextColor(with: viewModel.changeRow.first),
                    backgroundColor:    viewModel.premiumFeatureRowBackgroundColor(with: viewModel.changeRow.first),
                    accessorySFSymbol:  viewModel.changeRow.first ? SFSymbol.checkmark : nil,
                    accessoryColor:     viewModel.premiumFeatureRowAccessoryColor(with: viewModel.changeRow.first)
                ) {}
                .oneSAnimation()
                
                OneSRowButton(
                    .shortBig,
                    title:              Localized.Premium.futureUpdates,
                    textColor:          viewModel.premiumFeatureRowTextColor(with: viewModel.changeRow.second),
                    backgroundColor:    viewModel.premiumFeatureRowBackgroundColor(with: viewModel.changeRow.second),
                    accessorySFSymbol:  viewModel.changeRow.second ? SFSymbol.checkmark : nil,
                    accessoryColor:     viewModel.premiumFeatureRowAccessoryColor(with: viewModel.changeRow.second)
                ) {}
                .oneSAnimation(delay: 0.15)
                    
                OneSRowButton(
                    .shortBig,
                    title:              "\(Localized.Premium.realTree) 🌳",
                    textColor:          viewModel.premiumFeatureRowTextColor(with: viewModel.changeRow.third),
                    backgroundColor:    viewModel.premiumFeatureRowBackgroundColor(with: viewModel.changeRow.third),
                    accessorySFSymbol:  viewModel.changeRow.third ? SFSymbol.checkmark : SFSymbol.info,
                    accessoryColor:     viewModel.premiumFeatureRowAccessoryColor(with: viewModel.changeRow.third)
                ) {
                    FirebaseAnalyticsEvent.Premium.openRealTreeInfo()
                    SheetManager.shared.showSheet { PremiumGivingBackView() }
                }
                .oneSAnimation(delay: 0.3)
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
                    .oneSItemTransition()
                    .oneSAnimation(delay: 0.3)
                
                MountainContentView(viewModel: viewModel)
                    .padding(.top, MountainLayout.premiumHeight-100*Layout.multiplierWidth)
                    .padding(.horizontal, Layout.firstLayerPadding)
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 20)
        }
        
        
        private struct MountainContentView: View {
            
            @StateObject private var sheetManager = SheetManager.shared
            @ObservedObject var viewModel: PremiumModel
            
            
            var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    OneSText(text: Localized.Premium.youChoose, font: .custom(.bold, 24), color: .grayToBackground)
                    
                    HStack(spacing: 12) {
                        PremiumItem(viewModel: viewModel, item: viewModel.premiumItems[0])
                        PremiumItem(viewModel: viewModel, item: viewModel.premiumItems[1])
                    }
                    .padding(.bottom, 40)
                    
                    Group {
                        OneSText(text: Localized.note, font: .custom(.bold, 20), color: .grayToBackground)
                        
                        OneSMultilineText(text: Localized.Premium.noteTextPassage)
                    }
                    
                    OneSRowButton(.shortBig, title: Localized.Premium.restore, backgroundColor: .whiteToGray) {
                        viewModel.purchaseManager.restore()
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 24) {
                        OneSFootnoteButton(text: Localized.privacyPolicy, color: UserColor.user0.standard) {
                            FirebaseAnalyticsEvent.Profile.openPrivacyPolicy()
                            sheetManager.showSheet {
                                OneSSafariView(urlString: WebsiteURLString.privacyPolicy, tintColor: UserColor.user2.standard)
                            }
                        }
                        OneSFootnoteButton(text: Localized.terms, color: UserColor.user0.standard) {
                            FirebaseAnalyticsEvent.Profile.openTermsOfUse()
                            sheetManager.showSheet {
                                OneSSafariView(urlString: WebsiteURLString.termsOfUse, tintColor: UserColor.user2.standard)
                            }
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            private struct PremiumItem: View {
                
                @ObservedObject var viewModel: PremiumModel
                
                let item: PremiumProductItem
                
                
                var body: some View {
                    Button(action: { viewModel.premiumItemTapped(with: item) }) {
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    OneSText(text: Localized.premium, font: .custom(.semiBold, 22), color: .whiteToDarkGray)
                                    OneSText(text: Localized.lifetime.uppercased(), font: .custom(.extraBold, 10), color: .whiteToDarkGray)
                                }
                                Spacer()
                            }
                            
                            Spacer()
                            
                            OneSText(text: item.product?.price ?? "-", font: .custom(.extraBold, 28), color: .whiteToDarkGray)
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140*Layout.multiplierWidth)
                        .background(item.color)
                        .cornerRadius(10)
                        .oneSShadow(opacity: 0.1, blur: 10)
                        .oneSItemTransition()
                    }
                    .oneSButtonScaleStyle()
                }
            }
        }
    }
}
