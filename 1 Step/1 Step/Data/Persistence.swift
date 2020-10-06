//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init() {
        container = NSPersistentCloudKitContainer(name: "__Step")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
    }
}
