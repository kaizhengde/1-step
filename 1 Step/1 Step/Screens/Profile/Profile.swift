//
//  ProfileScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var profileModel = ProfileModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    ProfileHeaderView(profileModel: profileModel)
                        .padding(.bottom, -12)
                    
                    ProfileAccomplishmentsSectionView(profileModel: profileModel)
                    Group {
                        ProfileAppSectionView(profileModel: profileModel)
                        ProfileAboutSectionView(profileModel: profileModel)
                    }
                    .padding(.horizontal, Layout.firstLayerPadding)
                    .offset(y: -24)
                    
                    BottomView()
                }
            }
        }
    }
    
    
    private struct BottomView: View {
        
        var body: some View {
            VStack(spacing: 3) {
                OneSText(text: Localized.Profile.made, font: .footnote2, color: .grayToBackground)
                OneSText(text: "\(Localized.Profile.version) \(AppModel.General.version)", font: .footnote2, color: .grayToBackground)
                
                HStack(spacing: 16) {
                    OneSFootnoteButton(text: Localized.credits, color: UserColor.user2.standard) {
                        FirebaseAnalyticsEvent.Profile.openCredits()
                        SheetManager.shared.showSheet {
                            CreditsView()
                        }
                    }
                    OneSFootnoteButton(text: Localized.terms, color: UserColor.user2.standard) {
                        FirebaseAnalyticsEvent.Profile.openTermsOfUse()
                        SheetManager.shared.showSheet {
                            OneSSafariView(urlString: WebsiteURLString.termsOfUse, tintColor: UserColor.user2.standard)
                        }
                    }
                }
                .padding(.top, 20)
            }
            .padding(.bottom, 80*Layout.multiplierHeight)
        }
    }
}
