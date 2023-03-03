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

public class ApodManagerController {
    @Published public var items: [Apod]?
    
    private let currentMonth: TimelineMonth
    private let apiController: NasaApodManagerAPI
    private let storageController: ApodStorageController
    private var cancellables: Set<AnyCancellable> = []
    
    public init(currentMonth: TimelineMonth, pathToSqlite: String?) {
        self.currentMonth = currentMonth
        apiController = NasaApodManagerAPI()
        storageController = ApodStorageController(pathToSqlite: pathToSqlite)
        getLocalData()
    }
    
    public func getRemoteData(per: Int, page: Int) async throws {
        let response = try? await apiController.getApods(per: per, page: page)
        try await saveItems(response?.items)
    }
    
    public func getMonthData(currentMonth: TimelineMonth) async throws {
        let response = try? await apiController.getMonthsApods(startDate: currentMonth.startMonth, endDate: currentMonth.endMonth)
        try await saveItems(response?.items)
    }
    
    public func getAll() throws -> [ApodStorage]? {
        try storageController.getAllItems()
    }
    
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }

    // MARK: Private methdos
    private func getLocalData() {
            self.storageController
                .$items
                .map{$0?.mapToEntity()}
                .assign(to: \.items, on: self)
                .store(in: &self.cancellables)
    }
    
    private func saveItems(_ items: [NasaApodDto]?) async throws {
        let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
        // try storageController.saveItemsSql(itemsAdd)
        // self.items = try getAll()?.mapToEntity()
        for item in itemsAdd {
            try await storageController.asyncSaveItem(item)
        }
    }
}
