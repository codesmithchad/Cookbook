import UIKit

extension CALayer {
    func addSublayers(_ layers: CALayer...) {
        layers.forEach { (layer) in
            addSublayer(layer)
        }
    }

    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in edges {
            let sublayer = CALayer()
            switch edge {
            case .top:
                sublayer.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                sublayer.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .left:
                sublayer.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            case .right:
                sublayer.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            case .all:
                borderColor = color.cgColor
                borderWidth = width
                return
            default:
                break
            }
            sublayer.backgroundColor = color.cgColor
            self.addSublayer(sublayer)
        }
    }
}

extension CATransaction {
    class func withDisabledActions<T>(_ body: () throws -> T) rethrows -> T {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        defer {
            CATransaction.commit()
        }
        return try body()
    }
}
