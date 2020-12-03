//
//  CreditsModel.swift
//  1 Step
//
//  Created by Kai Zheng on 03.12.20.
//

import SwiftUI

class CreditsModel: ObservableObject {
    
    let color = UserColor.user2.standard
    
    lazy var rows: [(title: String, view: AnyView)] = [
        (title: "Notification Sounds", view: AnyView(EmptyView())),
        (title: "Introspect", view: AnyView(EmptyView()))
    ]
}

