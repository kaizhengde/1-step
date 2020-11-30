//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData

struct PersistenceManager {
    
    static let defaults = PersistenceManager()
    /*
     Unit Test
     static let defaults = PersistenceManager(inMemory: true)
     */
    
    let container: NSPersistentCloudKitContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "__Step")
        
        if inMemory {
          let description = NSPersistentStoreDescription()
          description.url = URL(fileURLWithPath: "/dev/null")
          self.container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
    }
    
    
    func saveContext() -> Bool {
        if context.hasChanges {
            do {
                try context.save()
                print("Sucess!!")
                return true
            } catch {
                PopupManager.shared.showTextPopup(.none, titleText: "Unknown Error", bodyText: "There was a problem saving your data but it is not your fault. Try to do it again or restart the app.", backgroundColor: .grayToBackground)
                return false
            }
        }
        return true 
    }
}
