//
//  ProfileHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSHeaderView(Localized.profile, trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) })) {
            AnyView(
                VStack {
                    ProfileImageView(profileModel: profileModel)
                    ProfileNameView()
                }
                .oneSItemTransition()
            )
        }
        .padding(.horizontal, Layout.firstLayerPadding)
    }
    
    
    private struct ProfileImageView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @ObservedObject var profileModel: ProfileModel
        
        
        var body: some View {
            Circle()
                .frame(width: 165, height: 165)
                .foregroundColor(.darkBackgroundToDarkGray)
                .oneSShadow(opacity: 0.15, blur: 8)
                .overlay(
                    Group {
                        if let selectedImage = profileModel.currentImage {
                            selectedImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 165, height: 165)
                                .clipShape(Circle())
                        } else {
                            SFSymbol.camera
                                .font(.system(size: 26, weight: .regular))
                                .foregroundColor(.neutralToDarkNeutral)
                                .frame(width: 165, height: 165)
                                .contentShape(Circle())
                        }
                        EmptyView()
                    }
                    .onTapGesture { profileModel.profileImageTapped() }
                )
                .oneSItemTapScale()
                .onAppear { profileModel.profileImageViewAppear() }
        }
    }
    
    
    private struct ProfileNameView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @StateObject private var popupManager = PopupManager.shared
        
        var name: String { userDefaultsManager.userName.isEmpty ? "You" : userDefaultsManager.userName }
        
        var body: some View {
            OneSText(text: name, font: .custom(.medium, 28), color: .grayToBackground)
                .onTapGesture {

                    popupManager.showPopup(.changeName, backgroundColor: UserColor.user0.standard, dismissOnTap: true) {
                        OneSTextFieldPopupView(titleText: "Name", bodyText: "Enter a new name.", initialInput: userDefaultsManager.userName, placeholder: "Your name", placeholderColor: UserColor.user0.dark, inputLimit: 20)
                    }
                }
                .onReceive(popupManager.confirmBtnDismissed) {
                    if $0.key == .changeName { userDefaultsManager.userName = $0.input.removeWhiteSpaces() }
                }
        }
    }
}
