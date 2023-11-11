//
//  TimelineMonth.swift
//  
//
//  Created by José Neto on 02/10/2022.
//

import Foundation
import storageclient

public protocol ApodTimeline: Codable {
    var value: String { get set }
}

public class TimelineMonth: Codable, ApodTimeline, Identifiable, Hashable {
    public static func == (lhs: TimelineMonth, rhs: TimelineMonth) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var value: String
    public var id: String { title }
    public var year: TimelineYear

    private var _apods: [Apod]? = []
    public var apods: [Apod]? {
        get {
            let storage = ApodStorageController()
            let items = try? storage.searchApods(startMonth: self.startMonth)?.mapToEntity() ?? []
            return items
        }
        set {
            _apods = newValue
        }
    }

    public init(value: String, title: String = "", year: TimelineYear, apods: [Apod]) {
        self.value = value
        self.year = year
        self._apods = apods
        self._title = title
    }

    public var startMonthDate: Date {
        guard let date: Date = Date(year: year.value.int, month: value.int, day: 1) else { return Date() }
        return date.beginning(of: .month) ?? Date()
    }
    
    public var startMonth: String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd"

        // The default timeZone on DateFormatter is the device’s
        // local time zone. Set timeZone to UTC to get UTC time.
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = utcDateFormatter.date(from: "\(year.value)-\(value)-01") else { return ""}

        let formatedString: String = utcDateFormatter.string(from: date)
        return formatedString
    }
    
    public var endMonth: String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd"

        guard let timeZone = TimeZone(abbreviation: "UTC") else { return ""}
        utcDateFormatter.timeZone = timeZone

        guard let date = utcDateFormatter.date(from: "\(year.value)-\(value)-01") else { return ""}

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone

        if var dateReturn = calendar.date(byAdding: .month, value: 1, to: date) {
            dateReturn = calendar.date(byAdding: .second, value: -1, to: dateReturn) ?? Date()

            if dateReturn.isInFuture {
                let today: Date = Date()
                let todayFormatedString: String = utcDateFormatter.string(from: today)
                return todayFormatedString
            }

            let formatedString: String = utcDateFormatter.string(from: dateReturn)
            return formatedString
        }
        return ""
    }

    public var numberDaysInCurrentMonth: Int? {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd"

        guard let timeZone = TimeZone(abbreviation: "UTC") else { return nil }
        utcDateFormatter.timeZone = timeZone

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone

        guard let startDate = utcDateFormatter.date(from: startMonth) else { return nil }
        
        if calendar.isDate(startDate, equalTo: Date(), toGranularity: .month) {
            let today = calendar.component(.day, from: Date())
            return today
        }

        let days = calendar.range(of: .day, in: .month, for: startDate)
        return days?.count
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
