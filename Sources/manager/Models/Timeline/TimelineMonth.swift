//
//  TimelineMonth.swift
//  
//
//  Created by José Neto on 02/10/2022.
//

import Foundation

public protocol ApodTimeline {
    var value: String { get set }
}

public class TimelineMonth: ApodTimeline, Identifiable, Hashable {
    public static func == (lhs: TimelineMonth, rhs: TimelineMonth) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var value: String
    public var id: String { title }
    public var year: TimelineYear
    public var apods: [Apod]
    
    public init(value: String, title: String = "", year: TimelineYear, apods: [Apod]) {
        self.value = value
        self.year = year
        self.apods = apods
        self._title = title
    }

    public var startMonthDate: Date {
        guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return Date() }
        return date.beginning(of: .month) ?? Date()
    }
    
    public var startMonth: String {
        guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return "" }
        let dateReturn = date.beginning(of: .month)
        let formatedString: String = dateReturn?.string(withFormat: "yyyy-MM-dd") ?? ""
        return formatedString
    }
    
    public var endMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "UTC")
        formatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return "" }
        guard let dateReturn = date.end(of: .month) else { return "" }
        
        if dateReturn.isInFuture {
            let today: Date = Date()
            let todayFormatedString: String = formatter.string(from: today)
            return todayFormatedString
        }
        
        let formatedString: String = formatter.string(from: dateReturn)
        return formatedString
    }
    
    public var endMonthDate: Date {
        guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return Date() }
        return date.end(of: .month) ?? Date()
    }
    
    private var _title: String
    public var title: String {
        get {
            guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return "" }
            return date.string(withFormat: "MMMM, yyyy")
        }
    }

    public static var currentMonth: TimelineMonth {
        if let month = TimelineYear.years.first?.months.first {
            return month
        } else {
            let date: Date = Date()
            return TimelineMonth(value: date.month.string,
                                 year: .init(value: date.year.string, months: []),
                                 apods: [])
        }
    }
    
    public static var defaultMonth: TimelineMonth {
        return TimelineMonth(value: "", year: .currentYear, apods: [])
    }
}
