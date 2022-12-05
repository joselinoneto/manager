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
    @Published public var currentMonth: TimelineMonth = TimelineMonth.defaultMonth
    
    private let apiController: NasaApodManagerAPI
    private let storageController: ApodStorageController
    private var cancellables: Set<AnyCancellable> = []
    
    public init(pathToSqlite: String?) {
        apiController = NasaApodManagerAPI()
        storageController = ApodStorageController(pathToSqlite: pathToSqlite)
        getLocalData()
    }
    
    private func getLocalData() {
        $currentMonth.receive(on: DispatchQueue.main).sink { [weak self] value in
            guard let self = self else { return }

            self.storageController
                .$items
                .map{$0?.mapToEntity()}
                .assign(to: \.items, on: self)
                .store(in: &self.cancellables)

            if value != TimelineMonth.defaultMonth {
                self.storageController
                    .observeApods(startDate: value.startMonthDate,
                                  endDate: value.endMonthDate)
            }
        }.store(in: &cancellables)
    }
    
    public func getRemoteData(per: Int, page: Int) async throws {
        let response = try? await apiController.getApods(per: per, page: page)
        try saveItems(response?.items)
    }
    
    public func getMonthData(currentMonth: TimelineMonth) async throws {
        self.currentMonth = currentMonth
        let response = try? await apiController.getMonthsApods(startDate: currentMonth.startMonth,
                                                               endDate: currentMonth.endMonth)
        try saveItems(response?.items)
    }
    
    public func saveItems(_ items: [NasaApodDto]?) throws {
        let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
        try storageController.saveItems(itemsAdd)
    }
    
    public func saveItems(_ items: [ApodStorage]?) throws {
        guard let items = items else { return }
        try storageController.saveItems(items)
    }
    
    public func getAll() throws -> [ApodStorage]? {
        try storageController.getAllItems()
    }
    
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }
}
