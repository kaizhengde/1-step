//
//  ContentView.swift
//  MofawawNew
//
//  Created by Kai Zheng on 19.10.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dragOffset: CGSize = .zero
    
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: 300)
                .foregroundColor(.green)
                .offset(x: dragOffset.width)
        }
        .gesture(DragGesture()
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                dragOffset = .zero
            }
        )
        .animation(.default)
    }
}


