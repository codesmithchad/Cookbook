import UIKit

extension UIButton {
    func setColor(_ color: UIColor, state: UIControl.State) {
        guard let coloredImage = UIImage.imageFromColor(color) else { return }
        setBackgroundImage(coloredImage, for: state)
    }

    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }

    // 우측 아이콘만 따로 적용하려면, UIbutton.semanticContentAttribute = .forceRightToLeft 을 사용해도 됨
    func setRightImage(_ image: UIImage,
                       paddingLeft: CGFloat = 0.0,
                       paddingCenter: CGFloat = 0.0,
                       paddingRight: CGFloat = 0.0,
                       for state: UIControl.State = .normal) {
        titleLabel?.sizeToFit()
        imageView?.sizeToFit()
        imageView?.contentMode = .scaleAspectFit
        setImage(image, for: state)

        let imageWidth = image.size.width
        let labelWidth = titleLabel?.frame.size.width ?? 0
        contentEdgeInsets = .init(top: 0, left: paddingLeft, bottom: 0, right: paddingRight + paddingCenter)
        titleEdgeInsets = .init(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
        imageEdgeInsets = .init(top: 0, left: labelWidth + paddingCenter, bottom: 0, right: -labelWidth - paddingCenter)
    }
}
