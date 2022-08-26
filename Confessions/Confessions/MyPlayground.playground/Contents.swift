import UIKit
import CoreFoundation

var greeting = "Hello, playground"


var fiveMins: Date = Date.now.addingTimeInterval(TimeInterval(5.0 * 60))
var oneHour: Date = Date.now.addingTimeInterval(TimeInterval(1.0 * 60 * 60))
var twoHours: Date = Date.now.addingTimeInterval(TimeInterval(3600 * 2.0))
var oneDay: Date = Date.now.addingTimeInterval(TimeInterval(1.0 * 86400))
var twelveDays: Date = Date.now.addingTimeInterval(TimeInterval(12.0 * 86400))
var oneHundredDays: Date = Date.now.addingTimeInterval(TimeInterval(100.0 * 86400))


func timeFromNow(date: Date) -> String {
    let dateTransformed = date.addingTimeInterval(TimeInterval(60))
    let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date.now, to: dateTransformed)
    
    guard let day = diffComponents.day else {
        print("error decoding time")
        return ""
    }
    
    if day > 0 {
        if day == 1 {
            return "1 day"
        } else {
            return "\(day) days"
        }
    }
    
    guard let hour = diffComponents.hour else {
        print("error decoding time")
        return ""
    }
    
    if hour > 0 {
        if hour == 1 {
            return "1 hour"
        } else {
            return "\(hour) hours"
        }
    }
    
    guard let minute = diffComponents.minute else {
        print("error decoding time")
        return ""
    }
    
    if minute == 1 {
        return "1 minute"
    } else {
        return "\(minute) mins"
    }
}


//var f = timeFromNow(date: twoHours)
var adss = timeFromNow(date: Date.now)
var g = timeFromNow(date: oneHour)
var a = timeFromNow(date: twoHours)
var s = timeFromNow(date: oneDay)
var r = timeFromNow(date: fiveMins)
var t = timeFromNow(date: twelveDays)
var q = timeFromNow(date: oneHundredDays)


var str = "2022-08-17T16:03:10+00:00"
var formatter = ISO8601DateFormatter()
formatter.date(from: str)
