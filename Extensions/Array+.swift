import Foundation

extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        return self[Swift.min(range.lowerBound, endIndex)..<Swift.min(range.upperBound, endIndex)]
    }

    @discardableResult
    public mutating func removeFirstIfExist() -> Array.Element? {
        return count > 0 ? removeFirst() : nil
    }
    @discardableResult
    public mutating func removeLastIfExist() -> Array.Element? {
        return count > 0 ? removeLast() : nil
    }
}
