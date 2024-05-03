//
//  KeychainManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

// MARK: - Uncomment below snippets and add KeychainAccess library to Swift Package Manager when you want to use Keychain
/*
import KeychainAccess

public class KeychainManager {
    public static let shared = KeychainManager()

    private init() {}

    private let keychain = Keychain(service: "com.hieplee.ProjectX")

    /// Retrieves a value from the keychain for the specified key.
    ///
    /// - Parameter key: The key associated with the value in the keychain.
    /// - Returns: The value associated with the key, or `nil` if not found.
    public func get(forKey key: String) -> String? {
        do {
            return try keychain.get(key)
        } catch {
            Logger.error("Error retrieving data from Keychain for key \(key): \(error)")
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
            try keychain.set(value, key: key)
        } catch {
            Logger.error("Error setting data in Keychain for key \(key): \(error)")
        }
    }

    /// Retrieves a Codable value from the keychain for the specified key.
    ///
    /// - Parameters:
    ///   - type: The type of the Codable value to be retrieved.
    ///   - key: The key associated with the Codable value in the keychain.
    /// - Returns: The Codable value associated with the key, or `nil` if not found.
    public func get<T: Codable>(type: T.Type, forKey key: String) -> T? {
        do {
            guard let data = try keychain.getData(key) else {
                return nil
            }

            let decoder = JSONDecoder()
            let value = try decoder.decode(type, from: data)

            return value
        } catch {
            Logger.error("Error retrieving data from Keychain for key \(key): \(error)")
            return nil
        }
    }

    /// Sets a Codable value in the keychain for the specified key.
    ///
    /// - Parameters:
    ///   - value: The Codable value to be stored in the keychain.
    ///   - key: The key associated with the Codable value in the keychain.
    public func set<T: Codable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)

            try keychain.set(data, key: key)
        } catch {
            Logger.error("Error retrieving data from Keychain for key \(key): \(error)")
        }
    }

    /// Removes a value from the keychain for the specified key.
    ///
    /// - Parameter key: The key associated with the value to be deleted.
    public func remove(forKey key: String) {
        do {
            try keychain.remove(key)
        } catch let error {
            Logger.error("Error removing data from Keychain for key \(key): \(error)")
        }
    }
}
*/
