//
//  SwiftDataManager.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 3/5/24.
//

import Combine
import Foundation
import SwiftData

public class SwiftDataManager {
    // MARK: - Properties
    public static var shared: SwiftDataManager!

    private var context: ModelContext?

    // MARK: - Constructors
    private init(container: ModelContainer) {
        context = ModelContext(container)
    }

    public static func configure(with container: ModelContainer) {
        shared = SwiftDataManager(container: container)
    }
}

// MARK: - Methods
public extension SwiftDataManager {
    /// Fetches objects of type `T` based on the provided fetch descriptor.
    ///
    /// - Parameter descriptor: The descriptor specifying the fetch parameters.
    /// - Returns: A `Future` containing an optional array of fetched objects.
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) -> Future<[T]?, Never> {
        return Future<[T]?, Never> { [weak self] promise in
            guard let self, let context else {
                return promise(.success(nil))
            }

            do {
                let model = try context.fetch(descriptor)
                return promise(.success(model))
            } catch {
                print("SwiftDataManager - fetch object error: \(error.localizedDescription)")
                return promise(.success(nil))
            }
        }
    }

    /// Inserts the specified model object into database.
    ///
    /// - Parameter model: The model object to be inserted.
    func insert<T: PersistentModel>(_ model: T) {
        guard let context else { return }

        context.insert(model)
    }

    /// Deletes the specified model object from database.
    ///
    /// - Parameter model: The model object to be deleted.
    func delete<T: PersistentModel>(_ model: T) {
        guard let context else { return }

        context.delete(model)
    }
}
