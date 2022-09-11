//
//  File.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation

public enum ApodType: String, Comparable {
    public static func < (lhs: ApodType, rhs: ApodType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    case image = "image"
    case video = "video"

}
