//
//  ProfileAppSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAppSectionView: View {
    
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: "App") {
            VStack(spacing: 20) {
                OneSDropDown(.long, title: "Settings", accessoryCustomSymbol: ProfileSymbol.settings) {
                    SettingsContentView(profileModel: profileModel)
                }
                
                OneSDropDown(.long, title: "Data & Privacy", accessorySFSymbol: ProfileSymbol.dataAndPrivacy) {
                    DataAndPrivacyContentView(profileModel: profileModel)
                }
                
                OneSRowButton(.long, title: "Help", accessorySFSymbol: ProfileSymbol.help) {}
            }
        }
    }
    
    
    private struct SettingsContentView: View {
        
        @StateObject private var userDefaultsManager = UserDefaultsManager.shared
        @ObservedObject var profileModel: ProfileModel
        
        var premium: Bool { userDefaultsManager.settingPremium }
        var selectedLanguage: OneSLanguage { userDefaultsManager.settingLanguage }
        var selectedAppearance: OneSAppearance { userDefaultsManager.settingAppearance }
        var notifications: Bool { userDefaultsManager.settingNotifications }
        
        
        var body: some View {
            VStack(spacing: 10) {
                OneSRowButton(
                    .shortSmall,
                    title: "Premium",
                    textColor: profileModel.appSelectedRowTitleColor(premium),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(premium),
                    accessoryText: profileModel.appSelectedRowAccessoryText(premium, enabled: "Yes!", disabled: "No"),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(premium),
                    action: { print("show PremiumView sheet.") }
                )
                                
                OneSDropDown(
                    .shortSmall,
                    title: "Language",
                    accessoryText: selectedLanguage.rawValue,
                    accessoryColor: profileModel.section1Color,
                    content: {
                        VStack(spacing: 10) {
                            ForEach(OneSLanguage.allCases, id: \.self) { language in
                                OneSRowSelectButton(
                                    Binding<Bool>(get: { selectedLanguage == language }, set: { _ in }),
                                    title: language.rawValue,
                                    selectedColor: profileModel.section1Color,
                                    action: { userDefaultsManager.settingLanguage = language }
                                )
                            }
                        }
                    }
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
                                    action: { userDefaultsManager.settingAppearance = appearance }
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
                    action: { userDefaultsManager.settingNotifications.toggle() }
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
                    title: "iCloud Sync",
                    textColor: profileModel.appSelectedRowTitleColor(iCloudSynch),
                    backgroundColor: profileModel.appSelectedRowBackgroundColor(iCloudSynch),
                    accessoryText: profileModel.appSelectedRowAccessoryText(iCloudSynch, enabled: "On", disabled: "Off"),
                    accessoryColor: profileModel.appSelectedRowAccessoryColor(iCloudSynch),
                    action: { userDefaultsManager.settingICloudSynch.toggle() }
                )
                
                OneSRowButton(.shortSmall, title: "Download iCloud data") {}
                
                OneSRowButton(.shortSmall, title: "Delete iCloud data") {}
                
                OneSRowButton(.shortSmall, title: "Reset all data") {}
                
                OneSRowButton(.shortSmall, title: "Privacy Policy") {}
            }
        }
    }
}
