//
//  ProfileHelpView.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

struct ProfileHelpView: View {
    
    @StateObject private var fullSheetManager = FullSheetManager.shared
    @ObservedObject var profileModel: ProfileModel
    @StateObject private var viewModel = ProfileHelpModel()
    
    
    var body: some View {
        ZStack {
            Color.backgroundToGray.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    OneSHeaderView(Localized.help, trailingButton: (.close, .grayToBackground, { fullSheetManager.dismiss() }))
                    
                    HelpGeneralView()
                    
                    HStack {
                        OneSSecondaryHeaderText(text: Localized.Help.frequentlyAsked, color: profileModel.section1Color)
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    HelpContentView(viewModel: viewModel)
                    
                    BottomView(profileModel: profileModel, viewModel: viewModel)
                }
                .padding(.horizontal, Layout.firstLayerPadding)
                .padding(.bottom, 100*Layout.multiplierHeight)
            }
        }
        .oneSAnimation()
    }
    
    
    private struct HelpGeneralView: View {
        
        @StateObject private var sheetManager = SheetManager.shared
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                OneSRowButton(.shortBig, title: GoalInfoCurrent.howItWorks.title) {
                    sheetManager.showSheet {
                        GoalInfoView(viewModel: GoalInfoModel(initialView: .howItWorks), selectedColor: UserColor.user0)
                    }
                }
                OneSRowButton(.shortBig, title: GoalInfoCurrent.examples.title) {
                    sheetManager.showSheet {
                        GoalInfoView(viewModel: GoalInfoModel(initialView: .examples), selectedColor: UserColor.user0)
                    }
                }
                OneSRowButton(.shortBig, title: Localized.tutorial) {
                    FirebaseAnalyticsEvent.Profile.openTutorial()
                    sheetManager.showSheet {
                        ProfileTutorialView()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
    private struct HelpContentView: View {
        
        @ObservedObject var viewModel: ProfileHelpModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(0..<viewModel.frequentlyAsked.count) { i in
                    OneSDropDown(.shortBig, title: viewModel.frequentlyAsked[i].title) {
                        OneSBackgroundMultilineText(text: viewModel.frequentlyAsked[i].text, big: false)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
    private struct BottomView: View {
        
        @ObservedObject var profileModel: ProfileModel
        @ObservedObject var viewModel: ProfileHelpModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                OneSMultilineText(text: Localized.Help.bottomText)
                
                OneSRowButton(.shortBig, title: Localized.contactMe, textColor: .backgroundToGray, backgroundColor: profileModel.section1Color) {
                    OneSMailHandler.handleShowMailView(success: {
                        SheetManager.shared.showSheet {
                            OneSMailView(email: MailString.hello, subject: Localized.contactRequest, tintColor: UserColor.user0.standard)
                        }
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
        }
    }
}
