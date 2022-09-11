//
//  Apod.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import SwifterSwift
import tools
import apiclient

//TODO: Remove downloadfile method and weak reference and change apod to struct
public struct Apod: Identifiable, Hashable {
    public static func == (lhs: Apod, rhs: Apod) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: UUID?
    public let date: String?
    public let explanation: String?
    public let mediaType: String?
    public let thumbnailUrl: String?
    public let title: String?
    public let url: String?
    public let hdurl: String?
    public let copyright: String?
    
    init(_ item: NasaApodDto) {
        self.id = item.id
        self.date = item.date
        self.explanation = item.explanation
        self.mediaType = item.mediaType
        self.thumbnailUrl = item.thumbnailUrl
        self.title = item.title
        self.url = item.url
        self.hdurl = item.hdurl
        self.copyright = item.copyright
    }
    
    init() {
        self.id = nil
        self.date = nil
        self.explanation = nil
        self.mediaType = nil
        self.thumbnailUrl = nil
        self.title = nil
        self.url = nil
        self.hdurl = nil
        self.copyright = nil
    }
    
    //MARK: Computed Properties
    private let hdSufix: String = "hd"

    public var currentDate: Date? {
        date?.date
    }
    
    public var formattedDate: String? {
        currentDate?.dateString(ofStyle: .full)
    }
    
    public var formattedExplanation: String? {
        guard let text = explanation else { return nil }
        return text.replacingOccurrences(of: "  ", with: "\n\n")
    }
    
    public var type: ApodType {
        guard let media = mediaType else { return .image }
        return ApodType(rawValue: media) ?? .image
    }
    
    public var imageUrl: URL? {
        // Local copy
        guard let id = id?.uuidString else { return nil }
        if let localUrl = FileStorage.shared.getLocalFile(fileName: id) {
            return localUrl
        }
        
        // Remote url
        guard let url = url else { return nil }
        switch type {
        case .image:
            return URL(string: url)
        case .video:
            guard let thumbnailUrl = thumbnailUrl else { return nil }
            return URL(string: thumbnailUrl)
        }
    }
    
    public var imageHdUrl: URL? {
        // Local copy
        guard let id = id?.uuidString else { return nil }
        let localHdFile: String = "\(id)\(hdSufix)"
        if let localUrl = FileStorage.shared.getLocalFile(fileName: localHdFile) {
            return localUrl
        }
        
        // Remote url
        guard let hdurl = hdurl else { return nil }
        switch type {
        case .image:
            return URL(string: hdurl)
        case .video:
            guard let thumbnailUrl = thumbnailUrl else { return nil }
            return URL(string: thumbnailUrl)
        }
    }
}
