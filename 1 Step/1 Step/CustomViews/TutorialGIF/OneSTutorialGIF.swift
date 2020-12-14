//
//  OneSTutorialGIF.swift
//  1 Step
//
//  Created by Kai Zheng on 08.12.20.
//

import SwiftUI
import Gifu

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
    
        var popupKey: PopupKey {
            switch self {
            case .firstSelectMountain:  return .firstSelectMountain
            case .firstSelectColor:     return .firstSelectColor
            case .firstOpenGoal:        return .firstOpenGoal
            }
        }
        
        var popupHeight: CGFloat {
            switch self {
            case .firstSelectMountain:  return 420*Layout.multiplierWidth
            case .firstSelectColor:     return 420*Layout.multiplierWidth
            case .firstOpenGoal:        return 500*Layout.multiplierWidth
            }
        }
        
        var popupDismissableDelay: DispatchTimeInterval {
            switch self {
            case .firstSelectMountain:  return .milliseconds(3_000)
            case .firstSelectColor:     return .milliseconds(3_000)
            case .firstOpenGoal:        return .milliseconds(12_000)
            }
        }
    }
    
    
    static func showPopup(for tutorial: OneSTutorial) {
        PopupManager.shared.showPopup(tutorial.popupKey, blurColor: .opacityDarker, backgroundColor: .backgroundToGray, height: tutorial.popupHeight, withPadding: false, dismissOnTapInside: true, tapDismissableDelay: tutorial.popupDismissableDelay, hapticFeedback: true) {
            OneSTutorialGIFView(tutorial: tutorial)
        }
    }
}


struct OneSTutorialGIFView: View {
    
    let tutorial: OneSTutorialGIF.OneSTutorial

    
    var body: some View {
        TutorialGIFView(tutorial: tutorial)
            .frame(width: TutorialGIFLayout.width, height: TutorialGIFLayout.height)
    }
}


private struct TutorialGIFView: UIViewRepresentable {
    
    @Environment(\.colorScheme) var appAppearance: ColorScheme
    let tutorial: OneSTutorialGIF.OneSTutorial
    
    
    func makeUIView(context: Context) -> UIView {
        let gif = appAppearance == .light ? tutorial.gifLight : tutorial.gifDark
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: TutorialGIFLayout.width, height: TutorialGIFLayout.height))
        
        let imageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: TutorialGIFLayout.width, height: TutorialGIFLayout.height))
        imageView.animate(withGIFNamed: gif)
        
        view.addSubview(imageView)
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
