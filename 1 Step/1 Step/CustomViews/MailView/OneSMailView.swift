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
    
    static let canSendMails = MFMailComposeViewController.canSendMail()
    
    static func showUnableToSendPopup() {
        PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
            OneSTextPopupView(titleText: Localized.error, bodyText: "Unable to send mails.\nPlease make sure that you have an active internet connection.\n\nAlso consider having valid e-mail accounts set up.")
        }
    }
}


struct OneSMailView: View {
    
    let subject: String
    let tintColor: Color
    
        
    var body: some View {
        MailView(subject: subject, tintColor: UIColor(tintColor))
            .foregroundColor(.grayToBackground)
            .accentColor(tintColor)
            .edgesIgnoringSafeArea(.all)
    }
}


fileprivate struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    let subject: String
    let tintColor: UIColor
    
    init(subject: String, tintColor: UIColor) {
        self.subject = subject
        self.tintColor = tintColor
    }


    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode

        init(presentation: Binding<PresentationMode>) {
            self._presentation = presentation
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
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                    OneSTextPopupView(titleText: Localized.thankYou, bodyText: "1 Step was made with the help of all of your feedback.\n\nYou are awesome!", bottomBtnTitle: "Done")
                }
            case .failed:
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral, hapticFeedback: true) {
                    OneSTextPopupView(titleText: Localized.error, bodyText: "Something went wrong. Unable to send mail.")
                }
            @unknown default: break
            }
        }
    }

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.view.tintColor = tintColor
        
        viewController.setToRecipients(["support@kaizheng.de"])
        viewController.setSubject(subject)
        viewController.mailComposeDelegate = context.coordinator
        
        return viewController
    }

    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}
