import Foundation

extension KeyedDecodingContainer {
    public func decodeIfPresentEx(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int? {
        var returnValue: Int?
        do {
            returnValue = try decodeIfPresent(type, forKey: key)
        } catch {
            let tempStringValue = try decodeIfPresent(String.self, forKey: key)
            returnValue = Int(tempStringValue ?? "0")
        }
        return returnValue
    }
}
