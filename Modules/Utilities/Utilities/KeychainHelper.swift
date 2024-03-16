//
//  KeychainHelper.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import KeychainAccess

public class KeychainHelper {
    public static let shared = KeychainHelper()
    
    private init() {}

    private let keychain = Keychain(service: "com.hieplee.HHEverything")
    
    /// Retrieves a value from the keychain for the specified key.
    ///
    /// - Parameter key: The key associated with the value in the keychain.
    /// - Returns: The value associated with the key, or `nil` if not found.
    public func get(forKey key: String) -> String? {
        do {
            return try keychain.get(key)
        } catch {
            print("Error retrieving data from Keychain for key \(key): \(error)")
            return nil
        }
    }
    
    /// Sets a value in the keychain for the specified key.
    ///
    /// - Parameters:
    ///   - value: The value to be stored in the keychain.
    ///   - key: The key associated with the value in the keychain.
    public func set(_ value: String, forKey key: String) {
        do {
            try keychain
                .accessibility(.whenUnlockedThisDeviceOnly, authenticationPolicy: .userPresence)
                .set(value, key: key)
        } catch {
            print("Error setting data in Keychain for key \(key): \(error)")
        }
    }
    
    /// Removes a value from the keychain for the specified key.
    ///
    /// - Parameter key: The key associated with the value to be deleted.
    public func remove(forKey key: String) {
        do {
            try keychain.remove(key)
        } catch let error {
            print("Error removing data from Keychain for key \(key): \(error)")
        }
    }
}
