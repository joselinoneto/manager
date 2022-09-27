//
//  ApodManagerController.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient
import tools
import RealmSwift
import Combine

public class ApodManagerController {
    @Published public var items: [Apod] = []
    @Published private var currentMonth: TimelineMonth
    
    private let apiController: NasaApodManagerAPI
    private var token: NotificationToken? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    public static let shared: ApodManagerController = ApodManagerController()
    
    init() {
        apiController = NasaApodManagerAPI()
        currentMonth = TimelineYear.currentMonth
        getLocalData()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func getLocalData() {
        $currentMonth.receive(on: DispatchQueue.main).sink { [weak self] value in
            self?.token?.invalidate()
            let realm = try! Realm(configuration: .init(deleteRealmIfMigrationNeeded: true))
            let localApods = realm.objects(ApodStorage.self).where { (item: Query<ApodStorage>) in
                item.postedDate >= value.startMonth.date && item.postedDate <= value.endMonth.date
            }
            self?.token = localApods.observe { [weak self] (result: RealmCollectionChange<Results<ApodStorage>>) in
                switch result {
                case .error(let error):
                    print(error.localizedDescription)
                case .initial(let results):
                    let items = results.reversed().mapToEntity()
                    self?.items = items
                case .update(let results, _, _, _):
                    self?.items = results.reversed().mapToEntity()
                }
            }
        }.store(in: &cancellables)
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
        let realm = try! await Realm()
        DispatchQueue.main.async {
            if let apiItems = items {
                let itemsAdd: [ApodStorage]? = apiItems.compactMap { (item: NasaApodDto) in
                    if realm.object(ofType: ApodStorage.self, forPrimaryKey: item.id) == nil {
                        return ApodStorage(item)
                    }
                    return nil
                }
                guard let itemsAdd = itemsAdd else { return }
                realm.writeAsync({
                    realm.add(itemsAdd)
                })
            }
        }
    }
    
    private func downloadContent(items: [Apod]) async throws {
        for item in items {
            try? await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }
    
    public func deleteItem(item: Apod) {
        let realm = try! Realm()
        guard let itemDelete = realm.object(ofType: ApodStorage.self, forPrimaryKey: item.id) else { return }
        try! realm.write {
            realm.delete(itemDelete)
        }
    }
    
    public func deleteAllData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
