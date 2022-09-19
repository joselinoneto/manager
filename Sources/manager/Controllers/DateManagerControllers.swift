//
//  File.swift
//  
//
//  Created by José Neto on 18/09/2022.
//

import Foundation
import SwifterSwift

public class DateManagerController {
    @Published public var items: [TimelineYear] = []
    
    public func buildTimeline() {
        guard let initialDate: Date = Date(year: 2020) else { return }
        guard let today: Date = Date() else { return }
        let todayNumber: Int = today.day
        var items: [TimelineYear] = []
        
        for year in initialDate.year...today.year {
            var timelineYear: TimelineYear = TimelineYear(value: year.string, months: [])
            for month in 1...12 {
                let futureDate: Date? = Date(year: year, month: month, day: todayNumber)
                if futureDate?.isInFuture ?? false {
                    break
                }
                timelineYear.months.append(.init(value: month.string, year: timelineYear))
            }
            items.append(timelineYear)
        }
        self.items = items
    }
    
    public static let shared: DateManagerController = DateManagerController()
}

public protocol Timeline {
    var value: String { get set }
}

public struct TimelineMonth: Timeline, Identifiable, Hashable {
    public static func == (lhs: TimelineMonth, rhs: TimelineMonth) -> Bool {
        lhs.id == rhs.id
    }
    public var value: String
    public var id: String { title }
    public var year: TimelineYear
    
    public var startMonth: String {
        guard let date: Date = Date(year: year.value.int, month: value.int) else { return "" }
        let dateReturn = date.beginning(of: .month)
        let formatedString: String = dateReturn?.string(withFormat: "YYYY-MM-dd") ?? ""
        return formatedString
    }
    
    public var endMonth: String {
        guard let date: Date = Date(year: year.value.int, month: value.int) else { return "" }
        var dateReturn = date.end(of: .month)
        if dateReturn?.isInFuture ?? false {
            dateReturn = Date()
        }
        
        let formatedString: String = dateReturn?.string(withFormat: "YYYY-MM-dd") ?? ""
        return formatedString
    }
    
    public var title: String {
        guard let date: Date = Date(year: year.value.int, month: value.int) else { return "" }
        return date.string(withFormat: "MMMM, YYYY")
    }
}

public struct TimelineYear: Timeline, Identifiable, Hashable {
    public static func == (lhs: TimelineYear, rhs: TimelineYear) -> Bool {
        lhs.value == rhs.value
    }
    public var id: String { value }
    public var value: String
    public var months: [TimelineMonth]
    
    public static var currentMonth: TimelineMonth {
        let date: Date = Date()
        return TimelineMonth(value: date.month.string, year: .init(value: date.year.string, months: []))
    }
}

