import UIKit

protocol ReusableTableViewCell {
    static var reuseIdentifier: String { get }
}
extension ReusableTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableTableViewCell {}
