//
//  ApodManagerController.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient
import tools
import Combine
import GRDB

public class ApodManagerController {
    @Published public var items: [Apod] = []
    @Published public var currentMonth: TimelineMonth = TimelineMonth.currentMonth
    
    private let apiController: NasaApodManagerAPI
    private var cancellables: Set<AnyCancellable> = []
    private let dbQueue: DatabaseQueue?
    public static let shared: ApodManagerController = ApodManagerController()
    
    init() {
        apiController = NasaApodManagerAPI()
        let dbFile: String = "\(FileStorage.shared.folderUrl?.absoluteString ?? "")/apod.sqlite"
        dbQueue = try? DatabaseQueue(path: dbFile)
        createTable()
        getLocalData()
    }
    
    private func createTable() {
        // 2. Define the database schema
        try? dbQueue?.write { db in
            try db.create(table: "ApodStorage", options: .ifNotExists) { t in
                t.column("id", .text).primaryKey()
                t.column("date", .text)
                t.column("postedDate", .text)
                t.column("explanation", .text)
                t.column("mediaType", .text)
                t.column("thumbnailUrl", .text)
                t.column("title", .text)
                t.column("url", .text)
                t.column("hdurl", .text)
                t.column("copyright", .text)
            }
        }
    }
    
    private func getLocalData() {
//        $currentMonth.receive(on: DispatchQueue.main).sink { [weak self, dbQueue] value in
//
////            do {
////                let localItems = try dbQueue.read { db in
////                    try ApodStorage.fetchAll(db)
////                }
////                self?.items = localItems.mapToEntity()
////            } catch {
////                print(error.localizedDescription)
////            }
//            /*
//            self?.token?.invalidate()
//            let realm = try! Realm(configuration: .init(deleteRealmIfMigrationNeeded: true))
//            let localApods = realm.objects(ApodStorage.self).where { (item: Query<ApodStorage>) in
//                item.postedDate >= value.startMonth.date && item.postedDate <= value.endMonth.date
//            }
//            self?.token = localApods.observe { [weak self] (result: RealmCollectionChange<Results<ApodStorage>>) in
//                switch result {
//                case .error(let error):
//                    print(error.localizedDescription)
//                case .initial(let results):
//                    let items = results.reversed().mapToEntity()
//                    self?.items = items
//                case .update(let results, _, _, _):
//                    self?.items = results.reversed().mapToEntity()
//                }
//            }
//            */
//        }.store(in: &cancellables)
        $currentMonth.receive(on: DispatchQueue.main).sink { [weak self, dbQueue] value in
            guard let dbQueue = dbQueue else { return }
            guard let self = self else { return }
            let observation = ValueObservation.tracking { db in
                try ApodStorage
                    .filter(Column("postedDate") >= value.startMonth.date && Column("postedDate") <= value.endMonth.date)
                    .fetchAll(db).mapToEntity()
            }
            observation
                .publisher(in: dbQueue)
                .sink { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { [weak self] (savedItems: [Apod]) in
                    self?.items = savedItems
                }.store(in: &self.cancellables)
        }.store(in: &cancellables)
//        guard let dbQueue = dbQueue else { return }
//        let observation = ValueObservation.tracking { db in
//            try ApodStorage.fetchAll(db).mapToEntity()
//        }
//        observation
//            .publisher(in: dbQueue)
//            .sink { result in
//                switch result {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                }
//            } receiveValue: { [weak self] (savedItems: [Apod]) in
//                self?.items = savedItems
//            }.store(in: &cancellables)
    }
    
    public func getRemoteData(per: Int, page: Int) async throws {
        let response = try? await apiController.getApods(per: per, page: page)
        try? await saveItems(response?.items)
        guard let items = response?.items.compactMap({ Apod($0) }) else { return }
        try? await downloadContent(items: items)
    }
    
    public func getMonthData(currentMonth: TimelineMonth) async throws {
        self.currentMonth = currentMonth
        let response = try? await apiController.getMonthsApods(startDate: currentMonth.startMonth, endDate: currentMonth.endMonth)
        try? await saveItems(response?.items)
        guard let items = response?.items.compactMap({ Apod($0) }) else { return }
        try? await downloadContent(items: items)
    }
    
    private func saveItems(_ items: [NasaApodDto]?) async throws {
        do {
            let itemsAdd: [ApodStorage] = items?.map { ApodStorage($0) } ?? []
            try await dbQueue?.write({ db in
                for item in itemsAdd {
                    if try ApodStorage.fetchOne(db, key: item.id) == nil {
                        try item.insert(db)
                    }
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func downloadContent(items: [Apod]) async throws {
        for item in items {
            try? await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }
    
    public func deleteItem(item: Apod) {
        
    }
    
    public func deleteAllData() async throws {
        
    }
}
