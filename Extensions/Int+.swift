import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "there's no number"
    }

    func withCommas(limit: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if self > limit, let string = numberFormatter.string(from: NSNumber(value: limit)) {
            return string.appending("+")
        }
        return numberFormatter.string(from: NSNumber(value: self)) ?? "unknown"
    }

    func limitTime() -> String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60

        return String(format: "%01i  :  %02i  :  %02i", hour, minute, second)
    }
    func toString() -> String {
        return String(self)
    }
}
