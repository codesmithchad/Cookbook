//
//  UIExtension.swift
//  Student
//
//  Created by Ajiaco on 28/03/2019.
//  Copyright © 2019 TPR. All rights reserved.
//

import UIKit

extension UIButton {
    // MARK: - 상태별로 버튼의 배경과 틴트 컬러 지정
    func setBgColor(color: UIColor, titleColor: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: forState)
        setTitleColor(titleColor, for: forState)
    }
}


extension UITextField {
    // MARK: - 플레이스홀더 폰트 사이즈 지정
    func placeholder(_ text: String, _ fontSize: CGFloat) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
    }
}


extension NSNotification {
    // MARK: - 옵저버 등록된 키보드의 높이를 리턴
    func keyboardHeight() -> CGFloat {
        let keyboardNotiInfo = userInfo! as NSDictionary
        let keyboardFrame:NSValue = keyboardNotiInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        return keyboardHeight
    }
}



// MARK: - IBInspectables
// https://spin.atomicobject.com/2017/07/18/swift-interface-builder/
@IBDesignable class DesignableView: UIView {
}

@IBDesignable class DesignableButton: UIButton {
}

//@IBDesignable class DesignableLabel: UILabel {
//}

extension UIView {
    // 코너
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    // 보더
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // 보더 컬러
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    // MARK: - Shadow
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

//    @IBInspectable var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
}
