import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    enum NavigationButtonBarDataType {
        case image(UIImage)
        case title(String)
        case category(String)
        case titleImage(String, UIImage)
    }

    struct NavigationButtonBar<BarButtonActionType> {
        var data: NavigationButtonBarDataType
        var kind: BarButtonActionType
        var spaceBefore: CGFloat = 0.0
        var spaceAfter: CGFloat = 0.0
    }

    func setNaviTitle(_ title: String,
                      backColor: UIColor = CommonDef.defaultNavigationBackColor,
                      textColor: UIColor = .white,
                      fontSize: CGFloat = 17,
                      fontWeight: UIFont.Weight = .semibold) {
        self.navigationItem.title = title
        navigationController?.navigationBar.barTintColor = backColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = textColor
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)]
    }

    func setNaviLeftBar<BarButtonActionType>(bag: DisposeBag,
                                             _ buttonTypes: NavigationButtonBar<BarButtonActionType>...) -> Observable<BarButtonActionType> {
        return setNavigationBar(pos: .left, bag: bag, buttonTypes)
    }

    func setNaviRightBar<BarButtonActionType>(bag: DisposeBag,
                                              _ buttonTypes: NavigationButtonBar<BarButtonActionType>...) -> Observable<BarButtonActionType> {
        return setNavigationBar(pos: .right, bag: bag, buttonTypes)
    }

    enum NavigationBarPosition {
        case left, right
    }
    func setNavigationBar<BarButtonActionType>(pos: NavigationBarPosition, bag: DisposeBag,
                                               _ buttonTypes: [NavigationButtonBar<BarButtonActionType>]) -> Observable<BarButtonActionType> {
        let barClickedObservable = PublishRelay<BarButtonActionType>()
        var items = [UIBarButtonItem]()
        for buttonType in buttonTypes {
            let button = UIButton(type: UIButton.ButtonType.system)
            switch buttonType.data {
            case .image(let image):
                button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            case .title(let title):
                button.setTitle(title, for: .normal)
            case .category(let title):
                button.setTitle(title, for: .normal)
                button.setRightImage(Asset.Assets.icInterest.image.withRenderingMode(.alwaysOriginal), for: .normal)
                button.titleLabel?.textColor = .gray000
                button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
                button.translatesAutoresizingMaskIntoConstraints = false
            case .titleImage(let title, let image):
                button.setTitle(title, for: .normal)
                button.setRightImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
            }
            if buttonType.spaceBefore > 0.0 {
                let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = buttonType.spaceBefore
                items.append(spaceItem)
            }
            items.append(UIBarButtonItem(customView: button))
            if buttonType.spaceAfter > 0.0 {
                let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = buttonType.spaceAfter
                items.append(spaceItem)
            }
            button.rx.tap
                .map { buttonType.kind }
                .bind(to: barClickedObservable)
                .disposed(by: bag)
        }
        switch pos {
        case .left:
            navigationItem.leftBarButtonItems = items
        case .right:
            navigationItem.rightBarButtonItems = items
        }
        return barClickedObservable.asObservable()
    }

    func setNavigationBarTitle(pos: NavigationBarPosition, title: String, index: Int = 0) {
        let barButtonItems: [UIBarButtonItem]?
        switch pos {
        case .left:
            barButtonItems = navigationItem.leftBarButtonItems
        case .right:
            barButtonItems = navigationItem.rightBarButtonItems
        }
        guard let barButton = barButtonItems?[safe: index] else { return }
        guard let button = barButton.customView as? UIButton else { return }
        button.setTitle(title, for: .normal)
    }

    func showAlertOneButton(_ message: String,
                            title: String? = nil,
                            done: String? = nil,
                            doneAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.stSkyBlue

        alert.addAction(UIAlertAction(title: done ?? Strings.dialogBtnOk, style: UIAlertAction.Style.cancel, handler: { action in
            doneAction?(action)
        }))

        present(alert, animated: true, completion: nil)
    }

    func showAlertDoneCancelButton(_ message: String,
                                   title: String? = nil,
                                   cancel: String? = nil,
                                   done: String? = nil,
                                   doneAction: ((UIAlertAction) -> Void)? = nil,
                                   cancelAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.stSkyBlue

        alert.addAction(UIAlertAction(title: cancel ?? Strings.applytutorPopupBtnclose, style: UIAlertAction.Style.cancel, handler: { action in
            if let cancelAction = cancelAction {
                cancelAction(action)
                return
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: done ?? Strings.dialogBtnOk, style: UIAlertAction.Style.default, handler: { action in
            doneAction?(action)
        }))
        present(alert, animated: true, completion: nil)
    }

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func hideKeyboard(disposeBag: DisposeBag, completion: (() -> Void )? = nil) {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.view.endEditing(true)
                completion?()
            })
            .disposed(by: disposeBag)
    }

    func showToastMessage(_ text: String) {
        view.makeToast(text)
    }
}

extension UIViewController {
    func addChildVC(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }

    func removeChildVC() {
        guard self.parent != nil else {
            return
        }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIViewController {
    func dismissChildViewController(animated: Bool, completion: (() -> Void)?) {
        if let presentedViewController = presentedViewController, presentedViewController != self {
            presentedViewController.dismissChildViewController(animated: animated) { [weak self] in
                guard let self = self else {
                    completion?()
                    return
                }
                if let nav = self as? UINavigationController {
                    nav.popToRootViewController(animated: animated)
                    nav.dismiss(animated: animated, completion: completion)
                    return
                }
                self.dismiss(animated: animated, completion: completion)
            }
            return
        }
        if let nav = self as? UINavigationController {
            nav.popToRootViewController(animated: animated)
            nav.dismiss(animated: animated, completion: completion)
            return
        }
        dismiss(animated: animated, completion: completion)
    }
}
