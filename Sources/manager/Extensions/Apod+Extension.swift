//
//  File.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient

extension Apod {
    public static var mockItems: [Apod] {
        NasaApodDto.mockItems.compactMap({ Apod($0) })
    }
}
