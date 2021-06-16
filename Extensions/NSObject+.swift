import UIKit

extension NSObject {
    func memAddress() -> String {
        let addr = unsafeBitCast(self, to: Int.self)
        return String(format: "%p", addr)
    }

    func screenSize() -> CGSize {
        UIScreen.main.bounds.size
    }

    func screenWidth() -> CGFloat {
        screenSize().width
    }
    func className() -> String? {
        return self.description.slice(start: ".", end: ":")
    }
}
