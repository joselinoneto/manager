//
//  File.swift
//  
//
//  Created by José Neto on 12/09/2022.
//

import Foundation
import apiclient
import GRDB

class ApodStorage: Codable, FetchableRecord, PersistableRecord  {
    var id: UUID?
    var date: String?
    var postedDate: Date?
    var explanation: String?
    var mediaType: String?
    var thumbnailUrl: String?
    var title: String?
    var url: String?
    var hdurl: String?
    var copyright: String?
    
    init(_ item: NasaApodDto) {
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
    }
}

extension Array where Element: ApodStorage {
    func mapToEntity() -> [Apod] {
        self.compactMap { Apod($0) }.sorted(by: \.currentDate).reversed()
    }
}
