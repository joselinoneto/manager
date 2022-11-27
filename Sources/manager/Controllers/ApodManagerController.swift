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
    @Published public var items: [Apod] = []
    @Published public var currentMonth: TimelineMonth = TimelineMonth.currentMonth
    
    private let apiController: NasaApodManagerAPI
    private let storageController: ApodStorageController
    private var cancellables: Set<AnyCancellable> = []
    //private let dbQueue: DatabaseQueue?
    public static let shared: ApodManagerController = ApodManagerController()
    
    init() {
        let dbFile: String = "\(FileStorage.shared.folderUrl?.absoluteString ?? "")/apod.sqlite"
        apiController = NasaApodManagerAPI()
        storageController = ApodStorageController(pathToSqlite: dbFile)
        getLocalData()
    }
    
    private func getLocalData() {
        $currentMonth.receive(on: DispatchQueue.main).sink { [weak self] value in
            guard let self = self else { return }
            self.storageController.$items.sink { [weak self] items in
                self?.items = items?.mapToEntity() ?? []
            }.store(in: &self.cancellables)
            self.storageController.observeApods(startDate: value.startMonth.date, endDate: value.endMonth.date)
        }.store(in: &cancellables)
    }
    
    public func getRemoteData(per: Int, page: Int) async throws {
        let response = try? await apiController.getApods(per: per, page: page)
        saveItems(response?.items)
    }
    
    public func getMonthData(currentMonth: TimelineMonth) async throws {
        self.currentMonth = currentMonth
        let response = try? await apiController.getMonthsApods(startDate: currentMonth.startMonth,
                                                               endDate: currentMonth.endMonth)
        saveItems(response?.items)
    }
    
    private func saveItems(_ items: [NasaApodDto]?) {
            let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
            storageController.saveItems(itemsAdd)
    }
    
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try? await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }
    
    public func deleteItem(item: Apod) {
        
    }
    
    public func deleteAllData() async throws {
        
    }
}
