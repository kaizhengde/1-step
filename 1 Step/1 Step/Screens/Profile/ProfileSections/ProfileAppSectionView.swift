//
//  ProfileAppSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAppSectionView: View {
    
    @StateObject private var fullSheetManager = FullSheetManager.shared
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: Localized.app) {
            VStack(spacing: 16) {
                OneSDropDown(.long, title: Localized.settings, accessoryCustomSymbol: ProfileSymbol.settings) {
                    SettingsContentView(profileModel: profileModel)
                }
                
                OneSDropDown(.long, title: Localized.dataAndPrivacy, accessorySFSymbol: ProfileSymbol.dataAndPrivacy) {
                    DataAndPrivacyContentView(profileModel: profileModel)
                }
                
                OneSRowButton(.long, title: Localized.help, accessorySFSymbol: ProfileSymbol.help) {
                    FirebaseAnalyticsEvent.Profile.openHelp()
                    fullSheetManager.showFullSheet { ProfileHelpView(profileModel: profileModel) }
                }
            }
        }
    }
    
    
    private struct SettingsContentView: View {
        
        @Environment(\.colorScheme) var appAppearance: ColorScheme
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @ObservedObject var profileModel: ProfileModel
        
        var premium: Bool { userDefaultsManager.settingPremium }
        var selectedLanguage: String { LocalizationHelper.languageDescription(of: Locale.preferredLanguages[0]) }
        var selectedAppearance: OneSAppearance { userDefaultsManager.settingAppearance }
        var selectedColorTheme: OneSColorTheme { userDefaultsManager.settingColorTheme }
        var selectedAppIcon: OneSAppIcon { userDefaultsManager.settingAppIcon }
        var notifications: Bool { userDefaultsManager.authorizationNotifications == .authorized }
        
        
        var body: some View {
            VStack(spacing: 10) {
                OneSRowButton(
                    .shortSmall,
                    title: Localized.premium,
                    textColor: profileModel.appSelectedRowTitleColor(premium),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(premium),
                    accessoryText: profileModel.appSelectedRowAccessoryText(premium, enabled: "\(Localized.yes)!", disabled: Localized.no),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(premium),
                    action: { FullSheetManager.shared.showFullSheet { PremiumView() } }
                )
                                
                OneSRowButton(
                    .shortSmall,
                    title: Localized.language,
                    accessoryText: selectedLanguage,
                    accessoryColor: profileModel.section1Color,
                    action: { UIApplication.shared.openOneSSettings() }
                )
                
                OneSDropDown(
                    .shortSmall,
                    title: Localized.appearance,
                    accessoryText: selectedAppearance.description,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        VStack(spacing: 10) {
                            ForEach(OneSAppearance.allCases, id: \.self) { appearance in
                                OneSRowSelectButton(
                                    Binding<Bool>(get: { selectedAppearance == appearance }, set: { _ in }),
                                    title: appearance.description,
                                    selectedColor: profileModel.section1Color,
                                    action: {
                                        userDefaultsManager.settingAppearance = appearance
                                        MainModel.shared.updateAppearance()
                                    }
                                )
                            }
                        }
                    }
                )
                
                OneSDropDown(
                    .shortSmall,
                    title: Localized.theme,
                    accessoryText: selectedColorTheme.description,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        VStack(spacing: 10) {
                            ForEach(OneSColorTheme.allCases, id: \.self) { colorTheme in
                                OneSRowSelectButton(
                                    Binding<Bool>(get: { selectedColorTheme == colorTheme }, set: { _ in }),
                                    title: colorTheme.description,
                                    selectedColor: profileModel.section1Color,
                                    action: {
                                        userDefaultsManager.settingColorTheme = colorTheme
                                    }
                                )
                            }
                        }
                    }
                )
                
                OneSDropDown(
                    .shortSmall,
                    title: Localized.appIcon,
                    accessoryText: selectedAppIcon.description,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            ForEach(appAppearance == .dark ? OneSAppIcon.darkIcons : OneSAppIcon.lightIcons, id: \.self) { appIcon in
                                appIcon.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                appIcon == userDefaultsManager.settingAppIcon ? profileModel.section1Color : Color.lightNeutralToLightGray,
                                                lineWidth: 1
                                            )
                                    )
                                    .oneSItemTransition()
                                    .oneSItemScaleTapGesture() {
                                        userDefaultsManager.settingAppIcon = appIcon
                                        AppModel.setAppIcon(with: appIcon.iconString)
                                    }
                            }
                        }
                        .frame(width: 280*Layout.multiplierWidth)
                    }
                )
                
                OneSRowButton(
                    .shortSmall,
                    title: Localized.notifications,
                    textColor: profileModel.appSelectedRowTitleColor(notifications),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(notifications),
                    accessoryText: profileModel.appSelectedRowAccessoryText(notifications, enabled: Localized.on, disabled: Localized.off),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(notifications),
                    action: { LocalNotificationManager.settingsNotificationBtnPressed() }
                )
            }
        }
    }
    
    
    private struct DataAndPrivacyContentView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @StateObject private var popupManager = PopupManager.shared
        @ObservedObject var profileModel: ProfileModel
        
        @State private var iCloudSynch = UserDefaultsManager.shared.settingICloudSynch
        var faceTouchID: Bool { UserDefaultsManager.shared.settingFaceTouchID }
        
        
        var body: some View {
            VStack(spacing: 10) {
                OneSRowButton(
                    .shortSmall,
                    title: Localized.iCloudSync,
                    textColor: profileModel.appSelectedRowTitleColor(iCloudSynch),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(iCloudSynch),
                    accessoryText: profileModel.appSelectedRowAccessoryText(iCloudSynch, enabled: Localized.on, disabled: Localized.off),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(iCloudSynch),
                    action: {
                        CloudKitHandler.cloudKitButtonToggled()
                        FirebaseAnalyticsEvent.Profile.toggleICloud(to: iCloudSynch)
                    }
                )
                
                if let authenticationType = BiometricsManager.getBiometricType().description {
                    OneSRowButton(
                        .shortSmall,
                        title: authenticationType,
                        textColor: profileModel.appSelectedRowTitleColor(faceTouchID),
                        backgroundColor: profileModel.appSelectedRowBackgroundColor(faceTouchID),
                        accessoryText: profileModel.appSelectedRowAccessoryText(faceTouchID, enabled: Localized.on, disabled: Localized.off),
                        accessoryColor: profileModel.appSelectedRowAccessoryColor(faceTouchID),
                        action: {
                            if faceTouchID {
                                BiometricsManager.authorize {
                                    if $0 { userDefaultsManager.settingFaceTouchID = false }
                                }
                            } else {
                                BiometricsManager.requestPermission {
                                    userDefaultsManager.settingFaceTouchID = true
                                }
                            }
                        }
                    )
                }
                
                OneSRowButton(.shortSmall, title: Localized.resetAllData) {
                    popupManager.showPopup(.resetAllData, backgroundColor: .grayStatic, height: 420*Layout.multiplierWidth, hapticFeedback: true) {
                        OneSTextFieldConfirmationPopupView(
                            titleText:          Localized.reset,
                            bodyText:           Localized.Profile.reset_confirmMessage,
                            textColor:          .backgroundStatic,
                            confirmationText:   Localized.Profile.reset_confirmInput,
                            placeholder:        Localized.Profile.reset_confirmInput,
                            placeholderColor:   .blackStatic,
                            inputLimit:         Localized.Profile.reset_confirmInput.count
                        )
                    }
                }
                
                OneSRowButton(.shortSmall, title: Localized.privacyPolicy) {
                    FirebaseAnalyticsEvent.Profile.openPrivacyPolicy()
                    SheetManager.shared.showSheet {
                        OneSSafariView(urlString: WebsiteURLString.privacyPolicy, tintColor: profileModel.section1Color)
                    }
                }
            }
            .onReceive(popupManager.confirmBtnDismissed) {
                if $0.key == .resetAllData {
                    let proceedReset = {
                        DataModel.shared.deleteAllGoals {
                            MainModel.shared.toScreen(.goals)
                        }
                    }
                    
                    if faceTouchID { BiometricsManager.authorize { if $0 { proceedReset() } } }
                    else { proceedReset() }
                }
            }
            .onReceive(CloudKitHandler.finished) { iCloudSynch = userDefaultsManager.settingICloudSynch } 
        }
    }
}



