//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData

final class PersistenceManager {
    
    static let defaults = PersistenceManager()
    
    lazy var container: NSPersistentContainer = {
        setupContainer()
    }()
    
    var context: NSManagedObjectContext { container.viewContext }
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: container.persistentStoreCoordinator)
    }
    
    
    func updateContainer() {
        _ = saveContext()
        container = setupContainer()
        DataModel.shared.fetchAllGoals {}
    }
    
    
    private func setupContainer() -> NSPersistentContainer {
        let newContainer: NSPersistentContainer?

        if UserDefaultsManager.shared.settingICloudSynch {
            newContainer = NSPersistentCloudKitContainer(name: "__Step")

            newContainer!.viewContext.automaticallyMergesChangesFromParent = true
            newContainer!.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

        } else {
            newContainer = NSPersistentContainer(name: "__Step")
            let description = newContainer!.persistentStoreDescriptions.first
            description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }

        guard let container = newContainer, let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions found")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        }

        return container
    }
    
    
    @objc func processUpdate(notification: NSNotification) {
        DataModel.shared.fetchAllGoals {
            print("Change: \(Date())")
        }
    }
    
    
    func saveContext() -> Bool {
        if context.hasChanges {
            do {
                try context.save()
                print("Sucess!!")
                
                return true
                
            } catch {
                let nserror = error as NSError
                print("Error when saving !!! \(nserror.localizedDescription)")
                print("Callstack :")
                for symbol: String in Thread.callStackSymbols {
                    print(" > \(symbol)")
                }
                
                PopupManager.shared.showPopup(backgroundColor: .darkNeutralToNeutral) {
                    OneSTextPopupView(titleText: Localized.unknownError, bodyText: Localized.Error.mocSave)
                }
                
                return false
            }
        }
        return true 
    }
}



/*Unit Test
//static let defaults = PersistenceManager(inMemory: true)
 
 if inMemory {
   description.url = URL(fileURLWithPath: "/dev/null")
   container.persistentStoreDescriptions = [description]
 }
 */

/*
 private func setupContainer() -> NSPersistentContainer {
     let newContainer = NSPersistentCloudKitContainer(name: "__Step")
     guard let description = newContainer.persistentStoreDescriptions.first else { fatalError("No Descriptions found") }
     
     if UserDefaultsManager.shared.settingICloudSynch {
         newContainer.viewContext.automaticallyMergesChangesFromParent = true
         newContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
         
     } else {
         description.cloudKitContainerOptions = nil
         description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
     }
     description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

     newContainer.loadPersistentStores { (storeDescription, error) in
         if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
     }

     return newContainer
 }
 */
