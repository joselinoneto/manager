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
        let items = try storageController.searchApods(startMonth: currentMonth.startMonth, endMonth: currentMonth.endMonth)
        if let apodItems = items?.mapToEntity() {
            DispatchQueue.main.async { [weak self] in
                self?.items = apodItems
            }
        }

        Task.retrying { [weak self] in
            let response = try await self?.apiController.getMonthsApods(startDate: currentMonth.startMonth, endDate: currentMonth.endMonth)
            try await self?.saveItems(response?.items)
        }
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
        try await storageController.saveItemsSql(itemsAdd)
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
