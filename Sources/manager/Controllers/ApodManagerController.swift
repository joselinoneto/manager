//
//  ApodManagerController.swift
//
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient
import storageclient
import tools
import GRDB
import ToolboxAPIClient
import OSLog
import SwifterSwift

public class ApodManagerController {
    // MARK: Local properties
    
    /// API Controller
    private let apiController: NasaApodManagerAPI
    
    /// Database Storage Controller
    private let storageController: ApodStorageController
    
    // MARK: Init
    
    /// Init Manager using month
    /// - Parameter currentMonth: Current Month
    public init() {
        apiController = NasaApodManagerAPI()
        storageController = ApodStorageController()
    }

    // MARK: Public Methods
    
    /// Get month data;
    /// Search remote and save locally.
    /// Will emit saved data.
    /// - Parameter currentMonth: Month to search data
    public func getMonthData(currentMonth: TimelineMonth) async throws -> [Apod]? {
        let task = Task.retrying { [weak self] in
            let response = try await self?.apiController.getMonthsApods(startDate: currentMonth.startMonth, endDate: currentMonth.endMonth)
            try await self?.saveItems(response?.items)
        }

        let result = await task.result
        let items = try storageController.searchApods(startMonth: currentMonth.startMonth, endMonth: currentMonth.endMonth)?.mapToEntity()

        switch result {
        case .success(()):
            return items
        case .failure(let error):
            Logger(subsystem: "ApodManagerControler", category: "Fetch data").error("ApodManagerError: \(error.localizedDescription)")
            return items
        }
    }
    
    /// Download images and save in Documents Folder
    /// - Parameter items: Items to downloads and save locally
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id.uuidString)
        }
    }
    
    public func updateFavorite(apod: Apod) async throws {
        if let storage = try storageController.getApod(id: apod.id) {
            storage.isFavorite?.toggle()
            try await storageController.asyncSaveItem(storage)
        }
    }
    
    public func searchFavorites() throws -> [Apod]? {
        try storageController.searchFavorites()?.mapToEntity()
    }
    
    public func searchApods(_ text: String) throws -> [Apod]? {
        text.isEmpty ? nil : try storageController.searchApods(text)?.mapToEntity()
    }
    
    public func getApod(id: UUID) -> Apod? {
        try? storageController.getApod(id: id)?.mapToEntity()
    }

    public func getApods(month: TimelineMonth?) -> [Apod]? {
        return try? storageController.searchApods(startMonth: month?.startMonth, endMonth: month?.endMonth)?.mapToEntity()
    }

    // MARK: Private methdos

    /// Save remote data locally
    /// - Parameter items: Remote Items
    private func saveItems(_ items: [NasaApodDto]?) async throws {
        let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
        try await storageController.saveItems(itemsAdd)
    }
}

extension Task where Failure == Error {
    @discardableResult
    static func retrying(priority: TaskPriority? = nil,
                         maxRetryCount: Int = 3,
                         operation: @Sendable @escaping () async throws -> Success) -> Task {
        Task(priority: priority) {
            for _ in 0..<maxRetryCount {
                try Task<Never, Never>.checkCancellation()
                do {
                    return try await operation()
                } catch {
                    guard let apiError = error as? APIErrors else { throw error }
                    switch apiError {
                    case .authenticationError:
                        await LoginManagerController.shared.loginDevice(deviceId: UUID().uuidString)
                    default:
                        throw error
                    }
                    continue
                }
            }

            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}
