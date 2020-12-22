//
//  SafariView.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI
import UIKit 
import SafariServices

struct OneSSafariView: View {
    
    let urlString: String
    let tintColor: Color
    
    
    var body: some View {
        SafariView(url: URL(string: urlString)!, tintColor: UIColor(tintColor))
            .foregroundColor(.grayToBackground)
            .edgesIgnoringSafeArea(.all)
    }
}


fileprivate struct SafariView: UIViewControllerRepresentable {

    let url: URL
    let tintColor: UIColor

    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let viewController = SFSafariViewController(url: url)
        viewController.preferredControlTintColor = tintColor
        viewController.view.tintColor = tintColor
        
        return viewController
    }

    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
