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
    let listenToInitialSync: AnyCancellable?
    
    init(_ key: UserDefaultKey, default: T) {
        self.key = key
        self.defaultValue = `default`
        
        listenToInitialSync = UserDefaultsManager.syncICloudDefaults.sink {
            let updateDefaultsData = {
                if let iCloudData = iCloudDefaults().data(forKey: key.rawValue) {
                    UserDefaults.standard.set(iCloudData, forKey: key.rawValue)
                }
            }
            
            let updateICloudData = {
                if let defaultsData = UserDefaults.standard.data(forKey: key.rawValue) {
                    iCloudDefaults().set(defaultsData, forKey: key.rawValue)
                }
            }
            
            print("----------------------------------")
            print(key.rawValue)
            
            if let lastICloudSaveDate = iCloudDefaults().object(forKey: key.dateValue) as? Date {
                print("iCLOUD: something is saved")
                if let lastDefaultsSaveDate = UserDefaults.standard.object(forKey: key.dateValue) as? Date {
                    print("DEFAULTS: something is saved")
                    if lastICloudSaveDate > lastDefaultsSaveDate {
                        updateDefaultsData()
                        print("iCLOUD: more up to date")
                    } else if lastDefaultsSaveDate > lastICloudSaveDate {
                        updateICloudData()
                        print("DEFAULTS: more up to date")
                    } else {
                        print("iCLOUD+DEFAULTS: same date")
                    }
                } else {
                    updateDefaultsData()
                    print("DEFAULTS: nothing is saved")
                }
            } else {
                updateICloudData()
                print("ICLOUD: nothing is saved")
            }
            
            print("----------------------------------")
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
                }
                
                print("Success.")
            }
            DispatchQueue.main.async { UserDefaultsManager.shared.objectWillChange.send() }
        }
    }
}
