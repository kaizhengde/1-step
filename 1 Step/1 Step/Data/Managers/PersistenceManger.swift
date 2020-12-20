//
//  Persistence.swift
//  1 Step
//
//  Created by Kai Zheng on 06.10.20.
//

import CoreData
import CloudKit

final class PersistenceManager {
    
    static let defaults = PersistenceManager()
    
    lazy var container: NSPersistentContainer = {
        initialSetupContainer()
    }()
    
    var context: NSManagedObjectContext { container.viewContext }
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: container.persistentStoreCoordinator)
    }
    
    
    func updateContainer() {        
        DispatchQueue.main.async {
            _ = self.saveContext()
            self.container = self.setupContainer()
            
            DataModel.shared.fetchAllGoals {}
        }
    }
    
    
    private func initialSetupContainer() -> NSPersistentContainer {
        do {
            let newContainer = try PersistentContainer.getContainer(iCloud: false)
            guard let description = newContainer.persistentStoreDescriptions.first else { fatalError("No description found") }

            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

            newContainer.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
            }
            return newContainer
        } catch {
            fatalError("Could not setup Container with error \(error)")
        }
    }
    
    
    private func setupContainer() -> NSPersistentContainer {
        let iCloud = UserDefaultsManager.shared.settingICloudSynch
        
        do {
            let newContainer = try PersistentContainer.getContainer(iCloud: iCloud)
            guard let description = newContainer.persistentStoreDescriptions.first else { fatalError("No description found") }
            
            if !iCloud {
                description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            }

            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

            newContainer.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
                
                if iCloud {
                    newContainer.viewContext.automaticallyMergesChangesFromParent = true
                    newContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                }
            }
            return newContainer
        } catch {
            fatalError("Could not setup Container with error \(error)")
        }
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
                print("Success Core-Data")
                
                return true
                
            } catch {
                let nserror = error as NSError
                print("Error when saving !!! \(nserror)")
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


