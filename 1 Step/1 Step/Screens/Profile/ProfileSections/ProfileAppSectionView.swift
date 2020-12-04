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
        OneSSectionView(title: "App") {
            VStack(spacing: 16) {
                OneSDropDown(.long, title: "Settings", accessoryCustomSymbol: ProfileSymbol.settings) {
                    SettingsContentView(profileModel: profileModel)
                }
                
                OneSDropDown(.long, title: "Data & Privacy", accessorySFSymbol: ProfileSymbol.dataAndPrivacy) {
                    DataAndPrivacyContentView(profileModel: profileModel)
                }
                
                OneSRowButton(.long, title: "Help", accessorySFSymbol: ProfileSymbol.help) {
                    fullSheetManager.showFullSheet { ProfileHelpView(profileModel: profileModel) }
                }
            }
        }
    }
    
    
    private struct SettingsContentView: View {
        
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
                    title: "Premium",
                    textColor: profileModel.appSelectedRowTitleColor(premium),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(premium),
                    accessoryText: profileModel.appSelectedRowAccessoryText(premium, enabled: "Yes!", disabled: "No"),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(premium),
                    action: {
                        if premium { ConfettiManager.shared.showConfetti(amount: .small) }
                        else { FullSheetManager.shared.showFullSheet { PremiumView() } }
                    }
                )
                                
                OneSRowButton(
                    .shortSmall,
                    title: "Language",
                    accessoryText: selectedLanguage,
                    accessoryColor: profileModel.section1Color,
                    action: { UIApplication.shared.openOneSSettings() }
                )
                
                OneSDropDown(
                    .shortSmall,
                    title: "Appearance",
                    accessoryText: selectedAppearance.rawValue,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        VStack(spacing: 10) {
                            ForEach(OneSAppearance.allCases, id: \.self) { appearance in
                                OneSRowSelectButton(
                                    Binding<Bool>(get: { selectedAppearance == appearance }, set: { _ in }),
                                    title: appearance.rawValue,
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
                    title: "Theme",
                    accessoryText: selectedColorTheme.rawValue,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        VStack(spacing: 10) {
                            ForEach(OneSColorTheme.allCases, id: \.self) { colorTheme in
                                OneSRowSelectButton(
                                    Binding<Bool>(get: { selectedColorTheme == colorTheme }, set: { _ in }),
                                    title: colorTheme.rawValue,
                                    selectedColor: profileModel.section1Color,
                                    action: { userDefaultsManager.settingColorTheme = colorTheme }
                                )
                            }
                        }
                    }
                )
                
                OneSRowButton(
                    .shortSmall,
                    title: "Notifications",
                    textColor: profileModel.appSelectedRowTitleColor(notifications),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(notifications),
                    accessoryText: profileModel.appSelectedRowAccessoryText(notifications, enabled: "On", disabled: "Off"),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(notifications),
                    action: { UIApplication.shared.openOneSSettings() }
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
                    title: "iCloud backup",
                    textColor: profileModel.appSelectedRowTitleColor(iCloudSynch),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(iCloudSynch),
                    accessoryText: profileModel.appSelectedRowAccessoryText(iCloudSynch, enabled: "On", disabled: "Off"),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(iCloudSynch),
                    action: { userDefaultsManager.settingICloudSynch.toggle() }
                )
                
                OneSRowButton(.shortSmall, title: "Export your data") {}
                                
                OneSRowButton(.shortSmall, title: "Delete all data") {}
                
                OneSRowButton(.shortSmall, title: "Privacy Policy") {}
            }
        }
    }
}
