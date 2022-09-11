//
//  ApodManagerController.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient
import tools

public struct ApodManagerController {
    public static let shared: ApodManagerController = ApodManagerController()
    private let apiController: NasaApodManagerAPI = NasaApodManagerAPI()
    
    public func getApods(per: Int = 100, page: Int = 1) async throws -> [Apod]? {
        let response = try? await apiController.getApods(per: per, page: page)
        let items = response?.items.compactMap({ Apod($0) })
        return items
    }
    
    public func downloadContent(items: [Apod]) async throws {
        for item in items {
            try? await FileStorage.shared.saveRemoteFile(imageUrl: item.imageUrl, fileName: item.id?.uuidString)
        }
    }
}
