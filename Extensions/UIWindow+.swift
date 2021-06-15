import UIKit

extension UIWindow {
    static var currentOrientation: UIInterfaceOrientation {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .portrait
    }
}
