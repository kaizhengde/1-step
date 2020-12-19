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
        setupContainer()
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
            print("Could not setup Container with Error: \(error)")
        }
        
        fatalError("Could not setup Container")
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


final class PersistentContainer {
    
    private static var _model: NSManagedObjectModel?
    
    private static func model(name: String) throws -> NSManagedObjectModel {
        if _model == nil {
            _model = try loadModel(name: name, bundle: Bundle.main)
        }
        return _model!
    }
    
    
    private static func loadModel(name: String, bundle: Bundle) throws -> NSManagedObjectModel {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
            throw CoreDataModelError.modelURLNotFound(forResourceName: name)
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoreDataModelError.modelLoadingFailed(forURL: modelURL)
       }
        return model
    }

    
    enum CoreDataModelError: Error {
        case modelURLNotFound(forResourceName: String)
        case modelLoadingFailed(forURL: URL)
    }

    
    public static func getContainer(iCloud: Bool) throws -> NSPersistentContainer {
        let name = "__Step"
        if iCloud {
            return NSPersistentCloudKitContainer(name: name, managedObjectModel: try model(name: name))
        } else {
            return NSPersistentContainer(name: name, managedObjectModel: try model(name: name))
        }
    }
}



/*Unit Test
//static let defaults = PersistenceManager(inMemory: true)
 
 if inMemory {
   description.url = URL(fileURLWithPath: "/dev/null")
   container.persistentStoreDescriptions = [description]
 }
 */


