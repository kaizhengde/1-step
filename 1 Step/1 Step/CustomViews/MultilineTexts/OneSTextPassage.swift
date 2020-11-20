//
//  OneSTextPassage.swift
//  1 Step
//
//  Created by Kai Zheng on 20.11.20.
//

import SwiftUI

enum OneSMultilineTextArt {
    
    case standard
    case bold
    case background
}


struct OneSTextPassageData {
    
    let text: String
    let textArt: OneSMultilineTextArt
}


struct OneSTextPassage: View {
    
    var passageData: [OneSTextPassageData]
    
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<passageData.count) { i in
                switch passageData[i].textArt {
                case .standard:
                    OneSMultilineText(text: passageData[i].text)
                case .bold:
                    OneSMultilineText(text: passageData[i].text, bold: true)
                case .background:
                    OneSBackgroundMultilineText(text: passageData[i].text)
                        .padding(.vertical, 16)
                }
            }
        }
    }
}
