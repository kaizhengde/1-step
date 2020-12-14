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
                                        AppModel.updateAppIconAppearance(with: appAppearance, themeChange: true)
                                    }
                                )
                            }
                        }
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
        @ObservedObject var profileModel: ProfileModel
        
        var iCloudSynch: Bool { userDefaultsManager.settingICloudSynch }
        
        
        var body: some View {
            VStack(spacing: 10) {
                OneSRowButton(
                    .shortSmall,
                    title: Localized.iCloudSync,
                    textColor: profileModel.appSelectedRowTitleColor(iCloudSynch),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(iCloudSynch),
                    accessoryText: profileModel.appSelectedRowAccessoryText(iCloudSynch, enabled: Localized.on, disabled: Localized.off),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(iCloudSynch),
                    action: { userDefaultsManager.settingICloudSynch.toggle() }
                )
                
                OneSRowButton(.shortSmall, title: Localized.exportData) {}
                                
                OneSRowButton(.shortSmall, title: Localized.resetAllData) {}
                
                OneSRowButton(.shortSmall, title: Localized.privacyPolicy) {
                    SheetManager.shared.showSheet {
                        OneSSafariView(urlString: WebsiteURLString.privacyPolicy, tintColor: profileModel.section1Color)
                    }
                }
            }
        }
    }
}



