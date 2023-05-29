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
import Combine
import GRDB
import ToolboxAPIClient

public class ApodManagerController {
    // MARK: Published Items

    /// Publisehd Apod Items, will emit when new apods are saved.
    @Published public var items: [Apod]?

    // MARK: Local properties

    /// Current month used to update data
    private let currentMonth: TimelineMonth

    /// API Controller
    private let apiController: NasaApodManagerAPI

    /// Database Storage Controller
    private let storageController: ApodStorageController

    /// DisposeBag
    private var cancellables: Set<AnyCancellable> = []

    // MARK: Init

    /// Init Manager using month
    /// - Parameter currentMonth: Current Month
    public init(currentMonth: TimelineMonth) {
        self.currentMonth = currentMonth
        apiController = NasaApodManagerAPI()
        storageController = ApodStorageController()
        getLocalData()
    }

    // MARK: Public Methods

    /// Get month data;
    /// Search remote and save locally.
    /// Will emit saved data.
    /// - Parameter currentMonth: Month to search data
    public func getMonthData(currentMonth: TimelineMonth) async throws {
        Task.retrying { [weak self] in
            let response = try await self?.apiController.getMonthsApods(startDate: currentMonth.startMonth, endDate: currentMonth.endMonth)
            if currentMonth == TimelineMonth.currentMonth {
                try await self?.saveItems(response?.items)
            } else {
                try await self?.saveItemsBatch(response?.items, currentMonth: currentMonth)
            }
        }
    }

    private func handleError(_ error: Error) async throws {

    }

    /// Get All Data
    /// - Returns: Returns an array of Apods
    public func getAll() throws -> [Apod]? {
        try storageController.getAllItems()?.mapToEntity()
    }

    /// Search locally Apod using date
    /// - Parameter currentMonth: TimelineMonth to search
    /// - Returns: Returns a locally Apod array
    public func searchLocalData(currentMonth: TimelineMonth) throws -> [Apod]? {
        let items = try storageController.searchApods(startMonth: currentMonth.startMonth, endMonth: currentMonth.endMonth)
        guard let items = items else { return nil }
        return items.mapToEntity()
    }

    /// Search locally Apod using ID
    /// - Parameter id: ID to search
    /// - Returns: Returns a locally Apod
    public func getApod(id: UUID) throws -> Apod? {
        try storageController.getApod(id: id)?.mapToEntity()
    }

    /// Download images and save in Documents Folder
    /// - Parameter items: Items to downloads and save locally
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }

    // MARK: Private methdos

    /// Observe storage data
    private func getLocalData() {
        self.storageController
            .$items
            .map{$0?.mapToEntity()}
            .assign(to: \.items, on: self)
            .store(in: &self.cancellables)
    }

    /// Save remote data locally
    /// - Parameter items: Remote Items
    private func saveItems(_ items: [NasaApodDto]?) async throws {
        let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []

        let tempItems = itemsAdd.mapToEntity()
        DispatchQueue.main.async { [weak self] in
            self?.items = tempItems
        }

        for item in itemsAdd {
            guard let id = item.id else { return }
            if try storageController.getApod(id: id) == nil {
                try storageController.saveItemsSql([item])
            }
        }
    }

    /// Save remote data locally
    /// - Parameter items: Remote Items
    private func saveItemsBatch(_ items: [NasaApodDto]?, currentMonth: TimelineMonth) async throws {
        let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
        try storageController.saveItemsSql(itemsAdd)
        let returnItems = try searchLocalData(currentMonth: currentMonth)

        DispatchQueue.main.async { [weak self] in
            self?.items = returnItems
        }
    }
}

extension Task where Failure == Error {
    @discardableResult
    static func retrying(
        priority: TaskPriority? = nil,
        maxRetryCount: Int = 3,
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            for _ in 0..<maxRetryCount {
                try Task<Never, Never>.checkCancellation()

                do {
                    return try await operation()
                } catch {
                    guard let apiError = error as? APIErrors else { throw error }
                    switch apiError {
                    case .authenticationError:
                        await LoginManagerController.shared.loginDevice()
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
