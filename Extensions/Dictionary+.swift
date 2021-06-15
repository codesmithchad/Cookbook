import Foundation

extension Dictionary {
    mutating func append(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
