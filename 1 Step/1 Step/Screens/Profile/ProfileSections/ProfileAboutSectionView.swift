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
        OneSSectionView(title: "About") {
            VStack(spacing: 36) {
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: "Send us your Feedback", accessorySFSymbol: ProfileSymbol.feedback, accessoryColor: UserColor.user0.standard) {}
                    
                    OneSRowButton(.long, title: "Request new Features", accessorySFSymbol: ProfileSymbol.request, accessoryColor: UserColor.user0.standard) {}
                    
                    OneSRowButton(.long, title: "Rate us on the App Store", textColor: .backgroundToGray, backgroundColor: UserColor.user0.standard, accessorySFSymbol: ProfileSymbol.rate, accessoryColor: .backgroundToGray) {}
                    
                    OneSRowButton(.long, title: "Share", accessorySFSymbol: ProfileSymbol.share, accessoryColor: UserColor.user0.standard) {}
                }
                
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: "Website", accessorySFSymbol: ProfileSymbol.website, accessoryColor: UserColor.user1.standard) {
                        sheetManager.showSheet {
                            OneSSafariView(urlString: "https://www.kaizheng.de/", tintColor: UserColor.user1.standard)
                        }
                    }
                    
                    OneSRowButton(.long, title: "Instagram", accessorySFSymbol: ProfileSymbol.instagram, accessoryColor: UserColor.user1.standard) {}
                }
                
                VStack(spacing: 16) {
                    OneSRowButton(.long, title: "The VFD Collective", accessorySFSymbol: ProfileSymbol.vfdCollective, accessoryColor: UserColor.user2.standard) {
                        sheetManager.showSheet {
                            OneSSafariView(urlString: "https://www.thevfdcollective.com/", tintColor: UserColor.user2.standard)
                        }
                    }
                    
                    OneSRowButton(.long, title: "Pastel Tree", accessorySFSymbol: ProfileSymbol.pastelTree, accessoryColor: UserColor.user2.standard) {
                        sheetManager.showSheet {
                            OneSSafariView(urlString: "https://www.etsy.com/shop/pastellbaum/", tintColor: UserColor.user2.standard)
                        }
                    }
                    
                    OneSRowButton(.long, title: "Plant a Tree", accessorySFSymbol: ProfileSymbol.plant, accessoryColor: UserColor.user2.standard) {
                        sheetManager.showSheet {
                            OneSSafariView(urlString: "", tintColor: UserColor.user2.standard)
                        }
                    }
                }
            }
        }
    }
}
