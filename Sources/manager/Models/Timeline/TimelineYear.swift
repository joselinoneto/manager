//
//  TimelineYear.swift
//  
//
//  Created by José Neto on 02/10/2022.
//

import Foundation
import SwifterSwift

public class TimelineYear: Timeline, Identifiable, Hashable {
    public static func == (lhs: TimelineYear, rhs: TimelineYear) -> Bool {
        lhs.value == rhs.value
    }
    
    public init(value: String, months: [TimelineMonth]) {
        self.value = value
        self.months = months
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var id: String { value }
    public var value: String
    public var months: [TimelineMonth]
    
    public static var currentYear: TimelineYear {
        if let year = years.last {
            return year
        } else {
            let date: Date = Date()
            return TimelineYear(value: date.year.string, months: [])
        }
    }
    
    public static var years: [TimelineYear] {
        guard let initialDate: Date = Date(year: 2015) else { return [] }
        guard let today: Date = Date() else { return [] }
        let todayNumber: Int = today.day
        var items: [TimelineYear] = []
        
        for year in initialDate.year...today.year {
            let timelineYear: TimelineYear = TimelineYear(value: year.string, months: [])
            for month in 1...12 {
                let futureDate: Date? = Date(year: year, month: month, day: todayNumber)
                if futureDate?.isInFuture ?? false {
                    break
                }
                timelineYear.months.append(.init(value: month.string, year: timelineYear, apods: []))
            }
            timelineYear.months.reverse()
            items.append(timelineYear)
        }
        
        return items.reversed()
    }
}
