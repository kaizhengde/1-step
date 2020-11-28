//
//  FirstStartScreen.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

struct FirstStartScreen: View {
    
    @StateObject private var mainModel = MainModel.shared
    @StateObject private var viewModel = FirstStartModel()
    
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.currentStep == .two {
                    OneSHeaderView(leadingButton: (.back, .grayToBackground, { viewModel.currentStep = .oneConfirm }))
                        .padding(.bottom, -20 + Layout.onlyOniPhoneXType(20))
                }
                
                switch viewModel.currentStep {
                case .one, .oneConfirm: StepOneView(viewModel: viewModel)
                case .two:              StepTwoView(viewModel: viewModel)
                default:                EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal, Layout.firstLayerPadding)
        }
        .background(
            ZStack(alignment: .top) {
                Color.backgroundToDarkGray.edgesIgnoringSafeArea(.all)
                
                GeometryReader { _ in
                    MountainView(viewModel: viewModel)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .frame(width: Layout.screenWidth)
        )
        .onAppear { viewModel.currentStep = .one }
        .oneSAnimation()
        .onTapGesture { viewModel.toStepOneConfirm() }
    }
    
    
    private struct StepOneView: View {
        
        @ObservedObject var viewModel: FirstStartModel
        
        
        var body: some View {
            VStack(spacing: 70*Layout.multiplierHeight) {
                OneSText(text: "Step 1 of 1", font: .custom(.semiBold, 16), color: UserColor.user1.standard)
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 28*Layout.multiplierHeight) {
                    OneSText(text: "Hi 🙂\nWhat’s your name?", font: .custom(.bold, 30), color: UserColor.user1.standard)
                    OneSText(text: "How should we call you?", font: .custom(.regular, 20), color: .grayToBackground)
                    OneSTextField(input: $viewModel.userNameInput, placeholder: "Your name", inputColor: UserColor.user0.standard, inputLimit: 20) { viewModel.toStepOneConfirm() }
                        .padding(.top, 20)
                    
                    if viewModel.currentStep == .oneConfirm {
                        HStack {
                            Spacer()
                            OneSSmallBorderButton(symbol: SFSymbol.continue, color: .grayToBackground) {
                                viewModel.currentStep = .two
                            }
                        }
                        .oneSItemTransition()
                        .oneSAnimation(delay: 0.3)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .oneSItemTransition()
            .onChange(of: viewModel.userNameInput) { if $0.isEmpty { viewModel.currentStep = .one } }
        }
    }
    
    
    private struct StepTwoView: View {
        
        @ObservedObject var viewModel: FirstStartModel
        
        
        var body: some View {
            VStack(spacing: 20*Layout.multiplierHeight) {
                OneSHeaderText(text: "Welcome")
                OneSText(text: "\(viewModel.userNameInput), we are excited to support you on your journey", font: .custom(.semiBold, 30), color: UserColor.user1.standard, alignment: .center)
                
                Spacer()
                
                OneSBorderButton(text: "START", color: .backgroundToGray) { viewModel.finishFirstStart() }
            }
            .padding(.bottom, 50*Layout.multiplierHeight)
            .padding(.horizontal, Layout.firstLayerPadding)
            .oneSItemTransition()
            .oneSAnimation(delay: 0.3)
        }
    }
    
    
    private struct MountainView: View {
        
        @ObservedObject var viewModel: FirstStartModel
        
        
        var body: some View {
            ZStack(alignment: .top) {
                MountainImage.mountain1.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Layout.screenWidth, height: MountainLayout.height)
                    .foregroundColor(.darkBackgroundToDarkGray)
                    .scaleEffect(0.7)
                    .offset(x: Layout.screenWidth/4, y: Layout.onlyOniPhoneXType(36))
                    .offset(y: viewModel.currentStep == .two ? 0 : MountainLayout.height*0.7)
                    .oneSMountainAnimation(delay: 0.3)
                
                MountainImage.mountain0.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Layout.screenWidth, height: MountainLayout.height)
                    .foregroundColor(UserColor.user0.standard)
                    .offset(y: viewModel.mountainOffsetY)
                    .oneSMountainAnimation(delay: 0.1)
            }
            .frame(height: MountainLayout.height)
            .offset(y: MountainLayout.offsetYNoScrollView)
        }
    }
}
