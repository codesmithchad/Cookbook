import Foundation

extension Date {
    static var localDate: Date {
        Date(timeInterval: TimeInterval(Calendar.current.timeZone.secondsFromGMT()), since: Date())
    }
    func toString(dateFormat format: String, timeZoneValue: TimeZone?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZoneValue ?? TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

    func toString(dateFormat format: String, timeZone: String? = nil) -> String {
        if let timeZone = timeZone {
            return toString(dateFormat: format, timeZoneValue: TimeZone(abbreviation: timeZone))
        }
        return toString(dateFormat: format, timeZoneValue: TimeZone.autoupdatingCurrent)
    }

    func toStringKST(dateFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return toString(dateFormat: format, timeZone: nil)
    }

    func toStringUTC(dateFormat format: String) -> String {
        return toString(dateFormat: format, timeZone: "UTC")
    }
    func getCompare(compareTo: Date, toGranularity: Calendar.Component = .minute) -> ComparisonResult {
        return Calendar.current.compare(self, to: compareTo, toGranularity: toGranularity)
    }
    func getDateString(_ year: Bool = false) -> String {
        let global = CommonDef.isGlobalLanguage
        // TODO: 서버에서 고정 피드에 내년 생성일자로 내려줘서 년도 표시를 임시로 막음
//        if year {
//            return toString(dateFormat: global ? "MMM dd'th', yyyy" : "yyyy년 MM월 dd일")
//        }
        return toString(dateFormat: global ? "MMM dd'th'" : "MM월 dd일")
    }
    func getTimeString() -> String {
        let global = CommonDef.isGlobalLanguage
        return toString(dateFormat: global ? "hh:mm a" : "a hh:mm")
    }

    static func getCompareString(_ compareTo: Date, toGranularity: Calendar.Component = .day, todayNone: Bool = false) -> String {
        let global = CommonDef.isGlobalLanguage
        let calendar = NSCalendar.current

        switch toGranularity {
        case .day:
            if calendar.isDateInToday(compareTo) {
                return todayNone ? "" : (global ? "Today" : "오늘")
            } else if calendar.isDateInYesterday(compareTo) {
                return global ? "Yesterday" : "어제"
            } else if calendar.isDateInTomorrow(compareTo) {
                return global ? "Tomorrow" : "내일"
            }
            let isSameYear = calendar.isDate(Date(), equalTo: compareTo, toGranularity: .year)
            return compareTo.getDateString(!isSameYear)
        default:
            break
        }
        return "none"
    }

    static func getLiveDate(dateString: String?, millisecond: Bool = false) -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        if millisecond {
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        }
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        guard let dateString = dateString, let date: Date = dateFormatter.date(from: dateString) else {
//            return nil
//        }
//        return date
        return getDate(dateString)
    }

    static func getDate(_ dateString: String?, loopCount: Int = 0) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if loopCount > 0 {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.\(String(repeating: "S", count: loopCount))'Z'"
        }
//        printLog("getDate dateString[\(dateString)] loopCount[\(loopCount)] dateFormat [\(String(describing: dateFormatter.dateFormat))]")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let wrapDateString = dateString, let date: Date = dateFormatter.date(from: wrapDateString) else {
            guard loopCount < 3 else { return nil }
            return getDate(dateString, loopCount: loopCount + 1)
        }
        return date
    }

    static func getNowPassString(_ dateString: String?) -> String {
        let global = CommonDef.isGlobalLanguage
        guard let date = getDate(dateString) else {
            printLog("getNowPassString error dateString [\(String(describing: dateString))]")
            return global ? "error" : "에러"
        }
        let calendar = Calendar.current
        let now = Date()

        let isPast = date.compare(now) != .orderedDescending
        if isPast {
            if calendar.isDateInToday(date) {
                let interval = calendar.dateComponents([.minute, .hour], from: date, to: now)
                if let hour = interval.hour {
                    if hour == 0, let minute = interval.minute {
                        let minute = (minute / 10) * 10
                        if minute == 0 {
                            return global ? "Just now" : "방금"
                        }
                        return global ? "\(minute)m ago" : "\(minute)분 전"
                    }
                    return global ? "\(hour)h ago" : "\(hour)시간 전"
                }
            } else if calendar.isDateInYesterday(date) {
                return global ? "Yesterday" : "어제"
            }
        } else {
            if calendar.isDateInToday(date) {
                return global ? "Today" : "오늘"
            } else if calendar.isDateInTomorrow(date) {
                return global ? "Tomorrow" : "내일"
            }
        }
        let isSameYear = calendar.isDate(now, equalTo: date, toGranularity: .year)
        return date.getDateString(!isSameYear)
    }
}
