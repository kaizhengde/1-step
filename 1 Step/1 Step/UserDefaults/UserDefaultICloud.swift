//
//  UserDefaultICloud.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import Foundation
import Combine

fileprivate typealias iCloudDefaults = NSUbiquitousKeyValueStore

@propertyWrapper
struct UserDefaultICloud<T: UserDefaultType> where T: Codable {
    let key: UserDefaultKey
    let defaultValue: T
    let listenToICloudChanges: AnyCancellable?
    
    init(_ key: UserDefaultKey, default: T) {
        self.key = key
        self.defaultValue = `default`
        
        listenToICloudChanges = UserDefaultsManager.syncICloudDefaults.sink {
            let updateDefaultsEntry = {
                if let iCloudData = iCloudDefaults().data(forKey: key.rawValue) {
                    UserDefaults.standard.set(iCloudData, forKey: key.rawValue)
                    DispatchQueue.main.async { UserDefaultsManager.shared.objectWillChange.send() }
                }
            }
            
            let updateICloudEntry = {
                if let defaultsData = UserDefaults.standard.data(forKey: key.rawValue) {
                    iCloudDefaults().set(defaultsData, forKey: key.rawValue)
                }
            }
            
            if let lastICloudEntryDate = iCloudDefaults().object(forKey: key.dateValue) as? Date {
                if let lastDefaultsEntryDate = UserDefaults.standard.object(forKey: key.dateValue) as? Date {
                    if lastICloudEntryDate > lastDefaultsEntryDate {
                        //iCloud entry more up to date
                        updateDefaultsEntry()
                    } else if lastDefaultsEntryDate > lastICloudEntryDate {
                        //UserDefault entry more up to date
                        updateICloudEntry()
                    }
                } else {
                    //No UserDefaults entry
                    updateDefaultsEntry()
                }
            } else {
                //No iCloud entry
                updateICloudEntry()
            }
        }
    }

    var wrappedValue: T {
        get {
            guard let data = (UserDefaults.standard.value(forKey: key.rawValue) ?? defaultValue) as? Data,
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                else { return defaultValue }
            return decodedData
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                let saveDate = Date()
                
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
                UserDefaults.standard.set(saveDate, forKey: key.dateValue)
                
                if UserDefaultsManager.shared.settingICloudSynch {
                    iCloudDefaults().set(encoded, forKey: key.rawValue)
                    iCloudDefaults().set(saveDate, forKey: key.dateValue)
                    iCloudDefaults().synchronize()
                    
                    print("Success iCloud.")
                }
                
                print("Success UserDefault.")
            }
            DispatchQueue.main.async { UserDefaultsManager.shared.objectWillChange.send() }
        }
    }
}
