//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData

struct PersistenceManager {
    
    static let defaults = PersistenceManager()
    
    let container: NSPersistentCloudKitContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    
    init() {
        container = NSPersistentCloudKitContainer(name: "__Step")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
    }
    
    
    func saveContext() -> Bool {
        if context.hasChanges {
            do {
                print("Sucess!!")
                try context.save()
                return true
            } catch {
                PopupManager.shared.showTextPopup(.none, titleText: "Unknown Error", bodyText: "There was a problem saving your data but it is not your fault. Try to do it again or restart the app.", backgroundColor: .grayToBackground)
                return false
            }
        }
        return true 
    }
}
