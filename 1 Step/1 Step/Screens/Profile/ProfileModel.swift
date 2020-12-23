//
//  ProfileModel.swift
//  1 Step
//
//  Created by Kai Zheng on 21.11.20.
//

import SwiftUI
import Combine

class ProfileModel: ObservableObject {
    
    var userDefaultsManager: UserDefaultsManager { UserDefaultsManager.shared }
    
    
    //MARK: - Profile Picture
    
    @Published var currentImage: Image?
    
    func updateProfileImage() {
        DispatchQueue.global().async {
            var savedImage: Image? = nil
            let savedUIImage = UIImage(data: self.userDefaultsManager.userProfileImage)
            
            if let savedUIImage = savedUIImage {
                savedImage = Image(uiImage: savedUIImage)
            }
            DispatchQueue.main.async { self.currentImage = savedImage }
        }
    }
    
    
    func profileImageTapped() {
        AuthorizationManager.requestPhotoLibraryAuthorizationIfNeeded { success in
            if success {
                SheetManager.shared.showSheet {
                    OneSImagePicker(deleteAction: {
                        self.userDefaultsManager.userProfileImage = Data()
                        SheetManager.shared.dismiss()
                    }) { selectedImage in
                        self.userDefaultsManager.userProfileImage = selectedImage.jpegData(compressionQuality: 0.5)!
                        FirebaseAnalyticsEvent.Profile.addProfilePicture()
                    }
                    .accentColor(UserColor.user0.standard)
                }
            }
        }
    }
    
    private let photoLibraryNoAccessSubscriber = PopupManager.shared.dismissed.sink {
        if $0 == .photoLibraryNoAccess { UIApplication.shared.openOneSSettings() }
    }
    

    //MARK: - Section 0: Accomplishments
    
    var accomplishmentsData: [(description: String, value: Int, color: Color, appearDelay: DispatchTimeInterval)] {
        [
            (Localized.Profile.accomplishment_steps, userDefaultsManager.accomplishmentTotalSteps, UserColor.user0.standard, Animation.Delay.none),
            (Localized.Profile.accomplishment_milestones, userDefaultsManager.accomplishmentTotalMilestonesReached, UserColor.user1.standard, Animation.Delay.halfOpacity),
            (Localized.Profile.accomplishment_goals, userDefaultsManager.accomplishmentTotalGoalsReached, UserColor.user2.standard, Animation.Delay.halfOpacity)
        ]
    }
    
    
    //MARK: - Section 1: App
    
    var section1Color: Color { UserColor.user0.standard }
    
    func appSelectedRowBackgroundColor(_ state: Bool) -> Color {
        return state ? section1Color : .whiteToDarkGray
    }
    
    
    func appSelectedRowTitleColor(_ state: Bool) -> Color {
        return state ? .whiteToDarkGray : .grayToBackground
    }
    
    
    func appSelectedRowAccessoryColor(_ state: Bool) -> Color {
        return state ? .whiteToDarkGray : section1Color
    }
    
    
    func appSelectedRowAccessoryText(_ state: Bool, enabled: String, disabled: String) -> String {
        return state ? enabled : disabled
    }
}
