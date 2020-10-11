//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData

struct PersistenceManager {
    
    static let defaults = PersistenceManager()
    private init() {}

    var container: NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: "__Step")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
        
        return container
    }
}
