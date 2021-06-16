import UIKit
import SnapKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }

    func fadeInOut(willShow: Bool = true, _ duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = willShow ? 1 : 0
//            self?.isUserInteractionEnabled = willShow
        }
    }

    func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    func debugBounds(_ color: UIColor = .red, _ width: CGFloat = 1) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.withAlphaComponent(0.6).cgColor
        
        let label = UILabel()
        label.text = className()
        addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
