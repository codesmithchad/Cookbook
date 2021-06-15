import UIKit
import RxSwift

extension UIAlertController {
    struct AlertAction<T> {
        var title: String?
        var style: UIAlertAction.Style
        var dataKind: T

        static func action(title: String?, dataKind: T, style: UIAlertAction.Style = .default) -> AlertAction {
            return AlertAction(title: title, style: style, dataKind: dataKind)
        }
    }

    static func present<T>(
        title: String?,
        style: UIAlertController.Style,
        actions: [AlertAction<T>],
        message: String? = nil,
        viewController: UIViewController? = CommonUtil.topViewController()
    )
    -> Observable<(Int, AlertAction<T>)> {
        return Observable.create { observer in
            guard let viewController = viewController else { return Disposables.create() }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext((index, action))
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }

    func setBackgroundColor(color: UIColor) {
        guard let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first else { return }
        contentView.backgroundColor = color
    }

    func setTitleInfo(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font: titleFont], range: NSRange(location: 0, length: title.count))
        }

        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], range: NSRange(location: 0, length: title.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }

    func setMessageInfo(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font: messageFont], range: NSRange(location: 0, length: message.count))
        }

        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: messageColorColor],
                                          range: NSRange(location: 0, length: message.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }

    func setTintInfo(color: UIColor) {
        self.view.tintColor = color
    }
}
