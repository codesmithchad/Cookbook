import UIKit

extension UINavigationController {
}

extension UINavigationController {
    @discardableResult
    func popViewController(animated: Bool, completion: (() -> Void)?) -> UIViewController? {
        guard let completion = completion else {
            return self.popViewController(animated: animated)
        }
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        let poppedViewController = self.popViewController(animated: animated)
        CATransaction.commit()
        return poppedViewController
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool, completion:(() -> Void)?) {
        guard let completion = completion else {
            return self.pushViewController(viewController, animated: animated)
        }
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
