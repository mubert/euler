/*
 https://projecteuler.net/problem=19
 
 You are given the following information, but you may prefer to do some research for yourself.
 
 * 1 Jan 1900 was a Monday.
 
 * Thirty days has September,
   April, June and November.
   All the rest have thirty-one,
   Saving February alone,
   Which has twenty-eight, rain or shine.
   And on leap years, twenty-nine.
 
 * A leap year occurs on any year evenly divisible by 4, but not on a century unless
   it is divisible by 400.

 How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
*/

import UIKit

enum DayOfWeek: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
    
    mutating func increment() {
        if self == .Sunday {
            self = .Monday
        }
        else {
            self = DayOfWeek(rawValue: self.rawValue + 1)!
        }
    }
}

enum Month: Int {
    case January = 1
    case February = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
    
    mutating func increment() {
        if self == .December {
            self = .January
        }
        else {
            self = Month(rawValue: self.rawValue + 1)!
        }
    }
}

struct Date {
    var day: Int
    var month: Month
    var year: Int
    
//    private(set) var dayOfWeek: DayOfWeek
    var dayOfWeek: DayOfWeek
    
    var daysInMonth: Int {
        switch month {
        case .January,
             .March,
             .May,
             .July,
             .August,
             .October,
             .December:
            return 31
            
        case .September,
             .April,
             .June,
             .November:
            return 30
            
        case .February:
            if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
                return 29
            }
            return 28
        }
    }
    
    mutating func incrementDay() {
        dayOfWeek.increment()
        if day == daysInMonth {
            day = 1
            if month == .December {
                year += 1
            }
            month.increment()
        }
        else {
            day += 1
        }
    }
}


var date = Date(day: 1, month: .January, year: 1900, dayOfWeek: .Monday)
var sundays = 0

// Increment to the start date
while date.day != 1 || date.month != .January || date.year != 1901 {
    date.incrementDay()
}

// Increment over the date range for the problem, marking Sundays as they occur
while date.day != 1 || date.month != .January || date.year != 2001 {
    if date.day == 1 && date.dayOfWeek == .Sunday {
        sundays += 1
    }
    date.incrementDay()
}
print(sundays)
