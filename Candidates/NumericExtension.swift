//
//  NumericExtension.swift
//  Student
//
//  Created by Ajiaco on 28/03/2019.
//  Copyright © 2019 TPR. All rights reserved.
//

import Foundation

extension String {
    // MARK: - 값이 숫자인 경우에만 true 리턴
    func allowNumericOnly() -> Bool {
        let characterSet = NSCharacterSet(charactersIn: "1234567890").inverted
        let filtered = self.components(separatedBy: characterSet).joined(separator: "")
        return filtered != self
    }
}


extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let numberString = numberFormatter.string(from: NSNumber(value:self)) {
            return numberString
        } else {
            return ""
        }
    }
}
