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
        let debugColor = color.withAlphaComponent(0.6)
        self.clipsToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = debugColor.cgColor

        let label = UILabel()
        label.text = className()
        let crossHairX = UIView()
        crossHairX.backgroundColor = debugColor
        let crossHairY = UIView()
        crossHairY.backgroundColor = debugColor
        addSubviews(label, crossHairX, crossHairY)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        crossHairX.snp.makeConstraints {
            $0.left.right.centerY.equalToSuperview()
            $0.height.equalTo(width)
        }
        crossHairY.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.width.equalTo(width)
        }
    }
}
