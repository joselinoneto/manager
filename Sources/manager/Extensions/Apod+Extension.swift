//
//  Apod+Extension.swift
//  Daily APoD
//
//  Created by José Neto on 09/03/2023.
//

import Foundation
import SwiftUI
import Kingfisher
import tools
import apiclient

extension Apod {
    public var image: Image? {
        get {
            guard let url = self.imageUrl else { return nil }
            guard let uiImage = try? UIImage(url: url) else { return nil }
            return Image(uiImage: uiImage)
        }
    }

    public var localImageUrl: URL? {
        switch type {
        case .image:
            guard let url = url else { return nil }
            return URL(string: url)
        case .video:
            guard let url = thumbnailUrl else { return nil }
            return URL(string: url)
        }
    }

    public var imageResource: Resource? {
        guard let imageUrl = self.localImageUrl else { return nil }
        return Kingfisher.ImageResource(downloadURL: imageUrl, cacheKey: String(id ?? 0))
    }

    public var canShareImage: Bool {
        return FileStorage.shared.getLocalFile(fileName: String(id ?? 0)) != nil
    }

    public static var mockItems: [Apod] {
        NasaApodDto.mockItems.compactMap({ Apod($0) })
    }
}
