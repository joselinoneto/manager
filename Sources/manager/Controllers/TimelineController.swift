//
//  TimelineController.swift
//  
//
//  Created by José Neto on 20/11/2022.
//

import Foundation

public class TimelineController {
    @Published public var timeline: [TimelineYear]
    
    public init() {
        timeline = TimelineYear.years
    }

    public func reload() {
        timeline.removeAll()
        timeline = TimelineYear.years
    }
}
