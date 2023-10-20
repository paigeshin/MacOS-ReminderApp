//
//  DueDate.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation

enum DueDate {
    case today
    case tomorrow
    case yesterday
    case custom(Date)
}

extension DueDate {
    
    var value: Date {
        switch self {
        case .today: return Date.today
        case .tomorrow: return Date.tomorrow
        case .yesterday: return Date.yesterday
        case .custom(let date): return date
        }
    }
    
    var title: String {
        switch self {
        case .today: return "Today"
        case .tomorrow: return "Tomorrow"
        case .yesterday: return "Yesterday"
        case .custom(let date): return date.formatAsString
        }
    }
    
    var isPastDue: Bool { self.value < Date() }
    
    static func from(value: Date) -> DueDate {
        let calendar = NSCalendar(identifier: .gregorian)!
        if calendar.isDateInToday(value) {
            return DueDate.today
        } else if calendar.isDateInTomorrow(value) {
            return DueDate.today
        } else if calendar.isDateInYesterday(value) {
            return DueDate.yesterday
        } else {
            return DueDate.custom(value)
        }
    }
    
}

extension Date {
    
    static var today: Date { Date() }
    static var yesterday: Date { Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: self.today)! }
    static var tomorrow: Date { Calendar(identifier: .gregorian).date(byAdding: .day, value: 1, to: self.today)! }
    var formatAsString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
}
