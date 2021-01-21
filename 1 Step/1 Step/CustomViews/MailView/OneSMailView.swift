//
//  OneSMailView.swift
//  1 Step
//
//  Created by Kai Zheng on 22.12.20.
//

import SwiftUI
import UIKit
import MessageUI

enum OneSMailHandler {
    
    static func handleShowMailView(success: @escaping () -> ()) {
        if MFMailComposeViewController.canSendMail() {
            success()
        } else {
            PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Mail.error_unableToSendMails)
            }
        }
    }
}


struct OneSMailView: View {
    
    let email: String
    let subject: String
    let tintColor: Color
    
        
    var body: some View {
        MailView(email: email, subject: subject, tintColor: UIColor(tintColor))
            .foregroundColor(.grayToBackground)
            .accentColor(tintColor)
            .edgesIgnoringSafeArea(.all)
    }
}


fileprivate struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    let email: String
    let subject: String
    let tintColor: UIColor
    
    init(email: String, subject: String, tintColor: UIColor) {
        self.email = email
        self.subject = subject
        self.tintColor = tintColor
    }


    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        let tintColor: UIColor
        
        init(presentation: Binding<PresentationMode>, tintColor: UIColor) {
            self._presentation = presentation
            self.tintColor = tintColor
        }

        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer { $presentation.wrappedValue.dismiss() }
            
            guard error == nil else {
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral) {
                    OneSTextPopupView(titleText: Localized.error, bodyText: error!.localizedDescription)
                }
                return
            }
            
            switch result {
            case .cancelled, .saved: break
            case .sent:
                PopupManager.shared.showPopup(backgroundColor: Color(tintColor), hapticFeedback: true) {
                    OneSTextPopupView(titleText: Localized.thankYou, bodyText: Localized.Mail.sent_thankYouText, bottomBtnTitle: Localized.continue)
                }
                ConfettiManager.shared.showConfetti(amount: .small)
            case .failed:
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                    OneSTextPopupView(titleText: Localized.error, bodyText: Localized.Mail.error_failedToSend)
                }
            @unknown default: break
            }
        }
    }

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation, tintColor: tintColor)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.view.tintColor = tintColor
        
        viewController.setToRecipients([email])
        viewController.setSubject(subject)
        viewController.mailComposeDelegate = context.coordinator
        
        return viewController
    }

    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}
