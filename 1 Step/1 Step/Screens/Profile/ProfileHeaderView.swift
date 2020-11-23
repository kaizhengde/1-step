//
//  ProfileHeaderView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @StateObject private var mainModel = MainModel.shared
    
    
    var body: some View {
        OneSHeaderView("Profile", trailingButton: (.close, .grayToBackground, { mainModel.toScreen(.goals) })) {
            AnyView(
                VStack {
                    ProfileImageView()
                    ProfileNameView()
                }
                .oneSItemTransition()
            )
        }
        .padding(.horizontal, Layout.firstLayerPadding)
    }
    
    
    private struct ProfileImageView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @StateObject private var sheetManager = SheetManager.shared
        
        
        var body: some View {
            Circle()
                .frame(width: 165, height: 165)
                .foregroundColor(.darkBackgroundToDarkGray)
                .oneSShadow(opacity: 0.15, y: 2, blur: 8)
                .overlay(
                    Group {
                        if userDefaultsManager.userProfileImage != Data() {
                            Image(uiImage: UIImage(data: userDefaultsManager.userProfileImage)!)
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
                    }
                    .onTapGesture {
                        sheetManager.showSheet {
                            OneSImagePicker(deleteAction: {
                                userDefaultsManager.userProfileImage = Data()
                                sheetManager.dismiss()
                            }) { selectedImage in
                                userDefaultsManager.userProfileImage = selectedImage.jpegData(compressionQuality: 0.5)!
                            }
                            .accentColor(UserColor.user0.standard)
                        }
                    }
                )
                .oneSItemTapScale()
        }
    }
    
    
    private struct ProfileNameView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @StateObject private var popupManager = PopupManager.shared
        
        var name: String { userDefaultsManager.userName.isEmpty ? "You" : userDefaultsManager.userName }
        
        var body: some View {
            OneSText(text: name, font: .custom(weight: Raleway.medium, size: 28), color: .grayToBackground)
                .onTapGesture {
                    popupManager.showTextFieldPopup(.changeName, titleText: "Name", bodyText: "Enter a new name.", input: userDefaultsManager.userName, placeholder: "Your name", placeholderColor: UserColor.user0.dark, textLimit: 20, backgroundColor: UserColor.user0.standard)
                }
                .onReceive(popupManager.buttonDismissed) {
                    if $0 == .changeName { userDefaultsManager.userName = popupManager.input }
                }
        }
    }
}
