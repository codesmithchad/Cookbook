//
//  InnerShadowExtension.swift
//  Student
//
//  Created by Ajiaco on 2019/11/13.
//  Copyright © 2019 TPR. All rights reserved.
//

// ref: https://curisious.com/how-to-create-inner-shadow-to-a-uiview-with-swift/

import UIKit


class InnerShadowExtension: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addShadow()
    }
    
    private func addShadow() {
        // constraint로 사이즈가 변경 가능성이 있는 경우 dispatch main queue 안에서 호출할 것
        let targetView = self
        
        let innerFrame = CGRect(x: 0, y: 0, width: targetView.frame.width, height: targetView.frame.height)
        let innerView = UIView(frame: innerFrame)
        innerView.backgroundColor = UIColor.clear
        innerView.addInnerShadow(onSide: UIView.innerShadowSide.all, shadowColor: .darkGray, shadowSize: 10.0, shadowOpacity: 10.0)
        
        var transform = CGAffineTransform.identity                  // define a transform
        transform = transform.rotated(by: CGFloat(Double.pi / 1))   // set transform's rotation
        transform = transform.scaledBy(x: 1, y: 1)              // set transform's scale
        innerView.transform = transform     // set transform to innerView
        
        targetView.addSubview(innerView)
    }
}



// MARK: - INNER SHADOW

extension UIView {
    
    // different inner shadow styles
    public enum innerShadowSide {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }
    
    // define function to add inner shadow
    public func addInnerShadow(onSide: innerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius: CGFloat = 0.0, shadowOpacity: Float) {
        // define and set a shaow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        // define shadow path
        let shadowPath = CGMutablePath()
        
        // define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
        
        // define inner rectangle for mask
        let innerFrame: CGRect = { () -> CGRect in
            switch onSide
            {
                case .all:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
                case .left:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
                case .right:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
                case .top:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
                case.bottom:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
                case .topAndLeft:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .topAndRight:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .bottomAndLeft:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .bottomAndRight:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .exceptLeft:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
                case .exceptRight:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
                case .exceptTop:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
                case .exceptBottom:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            }
        }()
        
        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)
        
        // set shadow path as show layer's
        shadowLayer.path = shadowPath
        
        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        
        // hide outside drawing area
        clipsToBounds = true
    }
}

