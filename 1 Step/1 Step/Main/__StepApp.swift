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
    
    let mainModel = MainModel.shared
    let goalsModel = GoalsModel()
    let goalAddModel = GoalCreateModel()
    
    let miniSheetManager = MiniSheetManager.shared
    let popupManager = PopupManager.shared
    let floaterManager = FloaterManager.shared

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(goalsModel)
                .environmentObject(goalAddModel)
        }
    }
}
