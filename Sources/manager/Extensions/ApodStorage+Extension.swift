//
//  File.swift
//  
//
//  Created by José Neto on 12/09/2022.
//

import Foundation
import apiclient
import storageclient

extension Array where Element: ApodStorage {
    func mapToEntity() -> [Apod] {
        self.compactMap { Apod($0) }.sorted(by: \.currentDate).reversed()
    }
}

extension ApodStorage {
    convenience init(_ item: NasaApodDto) {
        self.init()
        self.id = item.id
        self.date = item.date
        self.postedDate = item.postedDate
        self.explanation = item.explanation
        self.mediaType = item.mediaType
        self.thumbnailUrl = item.thumbnailUrl
        self.title = item.title
        self.url = item.url
        self.hdurl = item.hdurl
        self.copyright = item.copyright
        self.isFavorite = false
    }

    func mapToEntity() -> Apod {
        Apod(self)
    }
}
