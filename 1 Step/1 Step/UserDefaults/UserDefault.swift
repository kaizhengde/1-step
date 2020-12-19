//
//  UserDefault.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import Foundation

@propertyWrapper
struct UserDefault<T: UserDefaultType> where T: Codable {
    let key: UserDefaultKey
    let defaultValue: T
    
    init(_ key: UserDefaultKey, default: T) {
        self.key = key
        self.defaultValue = `default`
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
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
                print("Success.")
            }
            DispatchQueue.main.async { UserDefaultsManager.shared.objectWillChange.send() }
        }
    }
}
