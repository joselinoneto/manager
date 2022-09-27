//
//  File.swift
//  
//
//  Created by José Neto on 12/09/2022.
//

import Foundation
import RealmSwift
import apiclient

class ApodStorage: Object {
    @Persisted var id: UUID?
    @Persisted var date: String?
    @Persisted var postedDate: Date?
    @Persisted var explanation: String?
    @Persisted var mediaType: String?
    @Persisted var thumbnailUrl: String?
    @Persisted var title: String?
    @Persisted var url: String?
    @Persisted var hdurl: String?
    @Persisted var copyright: String?
    
    override init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(id: UUID, date: String, postedDate: Date?, explanation: String, mediaType: String, thumbnailUrl: String, title: String, url: String, hdurl: String, copyright: String) {
        self.init()
        self.id = id
        self.date = date
        self.postedDate = postedDate
        self.explanation = explanation
        self.mediaType = mediaType
        self.thumbnailUrl = thumbnailUrl
        self.title = title
        self.url = url
        self.hdurl = hdurl
        self.copyright = copyright
    }
    
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
