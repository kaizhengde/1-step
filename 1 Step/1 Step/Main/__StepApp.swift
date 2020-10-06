//
//  __StepApp.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

@main
struct __StepApp: App {
    
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
