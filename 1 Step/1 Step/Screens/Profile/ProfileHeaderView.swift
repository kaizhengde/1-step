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
    }
    
    
    private struct ProfileImageView: View {
        
        var body: some View {
            Circle()
                .frame(width: 150*Layout.multiplierWidth, height: 150*Layout.multiplierWidth)
                .foregroundColor(.darkBackgroundToDarkGray)
                .oneSShadow(opacity: 0.15, y: 2, blur: 8)
                .overlay(
                    SFSymbol.camera
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(.neutralToDarkNeutral)
                )
                .oneSItemTapScale()
        }
    }
    
    
    private struct ProfileNameView: View {
        
        @StateObject private var popupManager = PopupManager.shared
        
        var name: String { UserDefaultsManager.userName.isEmpty ? "You" : UserDefaultsManager.userName }
        
        var body: some View {
            OneSText(text: name, font: .custom(weight: Raleway.medium, size: 28), color: .grayToBackground)
                .onTapGesture {
                    popupManager.showTextFieldPopup(.changeName, titleText: "Name", bodyText: "Enter a new name.", input: UserDefaultsManager.userName, placeholder: "Your name", placeholderColor: UserColor.user0.get(.dark), textLimit: 20, backgroundColor: UserColor.user0.get())
                }
                .onReceive(popupManager.buttonDismissed) {
                    if $0 == .changeName { UserDefaultsManager.userName = popupManager.input }
                }
        }
    }
}
