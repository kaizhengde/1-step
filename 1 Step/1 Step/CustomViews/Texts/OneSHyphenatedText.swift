//
//  OneSHyphenatedText.swift
//  1 Step
//
//  Created by Kai Zheng on 11.12.20.
//

import SwiftUI

struct OneSHyphenatedText: View {
    
    let text: String
    let font: OneSFont
    let color: Color
    let width: CGFloat
    
    @State private var height: CGFloat = 0
    

    var body: some View {
        HyphenatedText(text: text, font: font.uiFont, color: UIColor(color), width: width, height: $height)
            .frame(height: height)
            .clipped()
    }
}


private struct HyphenatedText: UIViewRepresentable {
    
    let text: String
    let font: UIFont
    let color: UIColor
    let width: CGFloat
    @Binding var height: CGFloat
    
    
    func makeUIView(context: Context) -> UIView {
        let view    = UIView()
        let label   = makeHyphenatedLabel()
        
        view.addSubview(label)
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let oldLabels = uiView.subviews.compactMap { $0 as? UILabel }
        
        for oldLabel in oldLabels {
            oldLabel.removeFromSuperview()
        }
        
        let newLabel = makeHyphenatedLabel()
        
        uiView.addSubview(newLabel)
    }
    
    
    private func makeHyphenatedLabel() -> UILabel {
        let label   = UILabel()
        
        label.attributedText    = NSMutableAttributedString(string: text, attributes: getHyphenAttribute())
        label.font              = font
        label.textColor         = color
        
        label.lineBreakMode     = .byClipping
        label.numberOfLines     = 0
        
        label.frame.size.width  = width
        label.sizeToFit()
        
        DispatchQueue.main.async { height = label.frame.size.height }
        return label
    }
    
    
    private func getHyphenAttribute() -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0

        let hyphenAttribute = [
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
        ] as [NSAttributedString.Key : Any]
        
        return hyphenAttribute
    }
}
