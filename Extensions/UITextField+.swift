import UIKit
import RxCocoa
import RxSwift

extension UITextField {
    func leftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func rightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

    func setCustomClearButton(_ imageName: String) {
        if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: imageName), for: .normal)
            clearButton.setImage(UIImage(named: imageName), for: .highlighted)
        }
    }

    func setPlaceholderInfo(_ title: String, color: UIColor, font: UIFont? = nil) {
        attributedPlaceholder = NSAttributedString(string: title,
                                                   attributes: [
                                                    NSAttributedString.Key.foregroundColor: color,
                                                    NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
                                                   ])
    }

    enum TextFieldRightType {
        case passwordHidden
        case string(_ title: String,
                    color: UIColor? = .stSkyBlue,
                    disabledColor: UIColor? = .gray700,
                    font: UIFont? = .systemFont(ofSize: 14, weight: .semibold))
        case image(_ normal: UIImage, disabled: UIImage? = nil)
    }

    @discardableResult
    func setRightButton(type: TextFieldRightType, disposeBag: DisposeBag? = nil, rightPadding: CGFloat = 17) -> Observable<Void>? {
        var mode: UITextField.ViewMode = .never
        var view: UIView?
        var returnValue: Observable<Void>?
        switch type {
        case .passwordHidden:
            guard let disposeBag = disposeBag else { return nil }
            mode = .always
            let button = UIButton().then { button in
                button.setImage(Asset.Assets.icVisibility.image, for: .normal)
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7)
            }
            button.rx.tap.subscribe(onNext: { [weak self] in
                if self?.isSecureTextEntry ?? true {
                    self?.isSecureTextEntry = false
                    button.setImage(Asset.Assets.icInvisibility.image, for: .normal)
                    return
                }
                self?.isSecureTextEntry = true
                button.setImage(Asset.Assets.icVisibility.image, for: .normal)
            })
            .disposed(by: disposeBag)
            view = button
        case .string(let title, let color, let disabledColor, let font):
            mode = .always
            let button = UIButton().then { button in
                button.setTitle(title, for: .normal)
                button.setTitleColor(color, for: .normal)
                button.setTitleColor(disabledColor, for: .disabled)
                button.titleLabel?.font = font
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
            }
            returnValue = button.rx.tap.asObservable()
            view = button
        case .image(let normal, let disabled):
            mode = .always
            let button = UIButton().then { button in
                button.setImage(disabled, for: .disabled)
                button.setImage(normal, for: .normal)
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
            }
            returnValue = button.rx.tap.asObservable()
            view = button
        }
        self.rightView = view
        self.rightViewMode = mode
        return returnValue
    }

    func setRightButtonEnableFlag(_ isEnabled: Bool) {
        guard let button = self.rightView as? UIButton else { return }
        button.isEnabled = isEnabled
    }

    func setRightButtonChangeText(_ text: String) {
        guard let button = self.rightView as? UIButton else { return }
        button.setTitle(text, for: .normal)
    }
}

extension UITextField {
    func setText(_ data: String?) {
        self.text = data ?? ""
        self.sendActions(for: .valueChanged)
    }
}
