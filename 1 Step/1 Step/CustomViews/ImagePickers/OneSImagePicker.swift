//
//  OneSImagePicker.swift
//  1 Step
//
//  Created by Kai Zheng on 22.11.20.
//

import SwiftUI

struct OneSImagePicker: View {
    
    let deleteAction: () -> ()
    let onImagePicked: (UIImage) -> ()

    
    var body: some View {
        ZStack {
            ImagePicker(sourceType: .photoLibrary) { selectedImage in onImagePicked(selectedImage) }
            VStack {
                HStack {
                    Spacer()
                    Button(action: deleteAction) {
                        SFSymbol.delete
                            .font(.custom(Raleway.bold.weight, size: 19))
                            .foregroundColor(UserColor.user0.standard)
                    }
                    .padding()
                    .contentShape(Rectangle())
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
