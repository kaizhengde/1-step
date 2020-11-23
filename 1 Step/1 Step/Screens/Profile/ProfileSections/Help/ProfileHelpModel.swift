//
//  ProfileHelpModel.swift
//  1 Step
//
//  Created by Kai Zheng on 23.11.20.
//

import SwiftUI

class ProfileHelpModel: ObservableObject {
    
    lazy var rows: [(title: String, view: AnyView)] = [
        (title: "Can I change the order of my goals?", view: AnyView(EmptyView())),
        (title: "Can I delete reached goals?", view: AnyView(EmptyView())),
        (title: "How are steps calculated?", view: AnyView(EmptyView())),
        (title: "Is my data safe?", view: AnyView(EmptyView()))
    ]
}
