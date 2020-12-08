//
//  OneSTutorialGIF.swift
//  1 Step
//
//  Created by Kai Zheng on 08.12.20.
//

import SwiftUI
import SDWebImageSwiftUI

enum OneSTutorialGIF {
    
    enum OneSTutorial {
        
        case firstSelectMountain
        case firstSelectColor
        case firstOpenGoal
        
        var gifLight: String {
            switch self {
            case .firstSelectMountain:  return "TutorialSelectMountainLight"
            case .firstSelectColor:     return "TutorialSelectColorLight"
            case .firstOpenGoal:        return "TutorialGoalViewLight"
            }
        }
        
        var gifDark: String {
            switch self {
            case .firstSelectMountain:  return "TutorialSelectMountainDark"
            case .firstSelectColor:     return "TutorialSelectColorDark"
            case .firstOpenGoal:        return "TutorialGoalViewDark"
            }
        }
        
        var dismissableDelay: DispatchTimeInterval {
            switch self {
            case .firstSelectMountain:  return .milliseconds(2_500)
            case .firstSelectColor:     return .milliseconds(2_000)
            case .firstOpenGoal:        return .milliseconds(12_000)
            }
        }
    }
    
    
    static func showPopup(for tutorial: OneSTutorial, appAppearance: ColorScheme) {
        
        
        PopupManager.shared.showPopup(.firstSelectMountain, blurColor: .opacityDarker, backgroundColor: .backgroundToGray, height: 450*Layout.multiplierWidth, withPadding: false, tapDismissableDelay: tutorial.dismissableDelay, hapticFeedback: true) {
            content(for: tutorial, appAppearance: appAppearance)
        }
    }
    
    
    static func content(for tutorial: OneSTutorial, appAppearance: ColorScheme) -> some View {
        let gif = appAppearance == .light ? tutorial.gifLight : tutorial.gifDark
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: gif, withExtension: "gif")!)
        
        return
            AnimatedImage(data: imageData!)
                .resizable()
                .frame(width: Layout.popoverWidth, height: 450*Layout.multiplierWidth)
    }
}

