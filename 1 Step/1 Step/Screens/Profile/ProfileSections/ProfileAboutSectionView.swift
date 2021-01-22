//
//  ProfileAboutSectionView.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI

struct ProfileAboutSectionView: View {
    
    @StateObject private var userDefaultsManager = UserDefaultsManager.shared
    @StateObject private var sheetManager = SheetManager.shared
    @ObservedObject var profileModel: ProfileModel
    
    
    var body: some View {
        OneSSectionView(title: Localized.about) {
            VStack(spacing: 40) {
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: Localized.sendFeedback, accessorySFSymbol: ProfileSymbol.feedback, accessoryColor: UserColor.user0.standard) {
                        OneSMailHandler.handleShowMailView(success: {
                            sheetManager.showSheet {
                                OneSMailView(email: MailString.hello, subject: Localized.feedback, tintColor: UserColor.user0.standard)
                            }
                        })
                    }
                    
                    OneSRowButton(.long, title: Localized.requestFeatures, accessorySFSymbol: ProfileSymbol.request, accessoryColor: UserColor.user0.standard) {
                        OneSMailHandler.handleShowMailView(success: {
                            sheetManager.showSheet {
                                OneSMailView(email: MailString.hello, subject: Localized.featuresRequest, tintColor: UserColor.user0.standard)
                            }
                        })
                    }
                    
                    OneSRowButton(.long, title: Localized.rateOnAppStore, accessorySFSymbol: ProfileSymbol.rate, accessoryColor: UserColor.user0.standard) {
                        FirebaseAnalyticsEvent.Profile.openRateOnAppStore()
                        AppStoreManager.rateAppOnAppStore()
                    }
                    
                    OneSRowButton(.long, title: Localized.share, accessorySFSymbol: ProfileSymbol.share, accessoryColor: UserColor.user0.standard) {
                        FirebaseAnalyticsEvent.Profile.openShare()
                        AppStoreManager.shareApp()
                    }
                }
                
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: Localized.website, accessorySFSymbol: ProfileSymbol.website, accessoryColor: UserColor.user1.standard) {
                        FirebaseAnalyticsEvent.Profile.openWebsite()
                        sheetManager.showSheet {
                            OneSSafariView(urlString: WebsiteURLString.kaiZheng, tintColor: UserColor.user1.standard)
                        }
                    }
                    
                    OneSRowButton(.long, title: Localized.instagram, accessorySFSymbol: ProfileSymbol.instagram, accessoryColor: UserColor.user1.standard) {
                        FirebaseAnalyticsEvent.Profile.openInstagram()
                        sheetManager.showSheet {
                            OneSSafariView(urlString: WebsiteURLString.instagram, tintColor: UserColor.user2.standard)
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: Localized.vfdCollective, accessorySFSymbol: ProfileSymbol.vfdCollective, accessoryColor: UserColor.user2.standard) {
                        FirebaseAnalyticsEvent.Profile.openVfdCollective()
                        sheetManager.showSheet {
                            OneSSafariView(urlString: WebsiteURLString.vfdCollective, tintColor: UserColor.user2.standard)
                        }
                    }
                    
                    OneSRowButton(.long, title: Localized.plantTree, accessorySFSymbol: ProfileSymbol.plant, accessoryColor: UserColor.user2.standard) {
                        FirebaseAnalyticsEvent.Profile.openPlantTree()
                        sheetManager.showSheet {
                            OneSSafariView(urlString: WebsiteURLString.plantATree, tintColor: UserColor.user2.standard)
                        }
                    }
                }
            }
        }
    }
}
