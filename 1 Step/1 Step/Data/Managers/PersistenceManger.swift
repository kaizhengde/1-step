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
    
    
    func saveContext() {
        if context.hasChanges {
            do {
                print("Sucess!!")
                try context.save()
            } catch {
                print("Error while saving managedObjectContext \(error)")
            }
        }
    }
}
