//
//  __StepApp.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import SwiftUI

@main
struct __StepApp: App {
    
    let persistenceManager      = PersistenceManager.defaults
    let dataManager             = DataManager.defaults
    let dataModel               = DataModel.shared
        
    let mainModel               = MainModel.shared
    let goalsModel              = GoalsModel()
    let goalAddModel            = GoalCreateModel()
    let goalModel               = GoalModel.shared
        
    let sheetManager            = SheetManager.shared
    let miniSheetManager        = MiniSheetManager.shared
    let popupManager            = PopupManager.shared
    let floaterManager          = FloaterManager.shared
    let confettiManager         = ConfettiManager.shared
    
    let infinteAnimationManager = InfiniteAnimationManager.shared

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .environment(\.managedObjectContext, persistenceManager.context)
                .environmentObject(goalsModel)
                .environmentObject(goalAddModel)
        }
    }
}
