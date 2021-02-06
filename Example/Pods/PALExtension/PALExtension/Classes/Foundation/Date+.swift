//Copyright (c) 2021 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation

public typealias DateTuple = (year: String, month: String, day: String, hour: String, minute: String, second: String)
public typealias DateTupleInt = (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?)

public extension Date {
    
    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    var millisecondsSince1970: String {
        let date = (self.timeIntervalSince1970 * 1000.0).rounded()
        let value = "\(date)"
        guard let milliseconds = value.split(separator: ".").first else {
            return "\(value)"
        }
        return "\(milliseconds)"
    }
    
    var dateTuple: DateTuple {
        let calendar = Calendar.current
        
        let year = (calendar as NSCalendar).components(.year, from: self).year ?? 1990
        let month = (calendar as NSCalendar).components(.month, from: self).month ?? 6
        let day = (calendar as NSCalendar).components(.day, from: self).day ?? 1
        let hour = (calendar as NSCalendar).components(.hour, from: self).hour ?? 12
        let minute = (calendar as NSCalendar).components(.minute, from: self).minute ?? 0
        let second = (calendar as NSCalendar).components(.second, from: self).second ?? 0
        
        let yearString = "\(year)"
        let monthString = month < 10 ? "0\(month)" : "\(month)"
        let dayString = day < 10 ? "0\(day)" : "\(day)"
        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteString = minute < 10 ? "0\(minute)" : "\(minute)"
        let secondString = second < 10 ? "0\(second)" : "\(second)"
        
        return DateTuple(yearString, monthString, dayString, hourString, minuteString, secondString)
    }
    
    var dateTupleInt: DateTupleInt {
        let calendar = Calendar.current
        
        let year = (calendar as NSCalendar).components(.year, from: self).year
        let month = (calendar as NSCalendar).components(.month, from: self).month
        let day = (calendar as NSCalendar).components(.day, from: self).day
        let hour = (calendar as NSCalendar).components(.hour, from: self).hour
        let minute = (calendar as NSCalendar).components(.minute, from: self).minute
        let second = (calendar as NSCalendar).components(.second, from: self).second
        
        return DateTupleInt(year, month, day, hour, minute, second)
    }
    
    var timeZoneDate: Date {
        return self.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
    }

    var timeZoneRevertDate: Date {
        return self.addingTimeInterval(-TimeInterval(TimeZone.current.secondsFromGMT()))
    }

    func getDate(_ of: String = "-") -> String {
        let tuple = self.dateTuple
        return "\(tuple.year)\(of)\(tuple.month)\(of)\(tuple.day)"
    }
    
    func getTime(_ of: String = ":") -> String {
        let tuple = self.dateTuple
        return "\(tuple.hour)\(of)\(tuple.minute)\(of)\(tuple.second)"
    }
    
    func betweenDays(_ toDate: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: toDate).day ?? 0
    }
    
    func equalYear(_ toDate: Date) -> Bool {
        let currentTuple = self.dateTuple
        let dateTuple = toDate.dateTuple
        return currentTuple.year == dateTuple.year
    }
    
    func equalMonth(_ toDate: Date) -> Bool {
        let currentTuple = self.dateTuple
        let dateTuple = toDate.dateTuple
        return currentTuple.year == dateTuple.year && currentTuple.month == dateTuple.month
    }
    
    func equalDay(_ toDate: Date) -> Bool {
        let currentTuple = self.dateTuple
        let dateTuple = toDate.dateTuple
        return currentTuple.year == dateTuple.year && currentTuple.month == dateTuple.month && currentTuple.day == dateTuple.day
    }
    
    static func format(_ date: String, format: String, timeZone: TimeZone = TimeZone.current, locale: NSLocale = NSLocale(localeIdentifier: Locale.current.identifier)) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale as Locale
        return dateFormatter.date(from: date)
    }
}
