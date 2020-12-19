//
//  NetworkManager.swift
//  1 Step
//
//  Created by Kai Zheng on 19.12.20.
//

import Foundation
import Reachability

final class NetworkManager {
    
    var reachability: Reachability!
    
    static let shared = NetworkManager()
    private init() {
        reachability = try! Reachability()
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    static func startNotifier() {
        do {
            try NetworkManager.shared.reachability.startNotifier()
        } catch {
            print("Unable to stop notifier")
        }
    }
    
    
    static func stopNotifier() {
        NetworkManager.shared.reachability.stopNotifier()
    }

    
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if NetworkManager.shared.reachability.connection != .unavailable {
            completed(NetworkManager.shared)
        }
    }
    
    
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if NetworkManager.shared.reachability.connection == .unavailable {
            completed(NetworkManager.shared)
        }
    }
}
