import UIKit

extension String {
    var encodeURL: URL? {
        if let urlData = removingPercentEncoding {
            return URL(string: urlData.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
        return URL(string: addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }

    func attributedString(_ lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: attributedString.length))
        return attributedString
    }
    func toInt(value: Int = 0) -> Int {
        return Int(self) ?? value
    }

    func slice(start: String, end: String) -> String? {
        guard let rangeStart = range(of: start)?.upperBound else { return nil }
        guard let rangeEnd = self[rangeStart...].range(of: end)?.lowerBound else { return nil }
        return String(self[rangeStart..<rangeEnd])
    }
}

extension String {
    // 사용 예 : label.attributedText = "HTMLSTRING".htmlEscaped()
    func htmlEscaped(font: UIFont? = nil, colorHex: String = "#000000", lineSpacing: CGFloat = 1.5) -> NSAttributedString {
        let htmlFont = font ?? STFont.regular.of(size: 15)
        let style = """
                    <style>
                    p.normal {
                      line-height: \(lineSpacing);
                      font-size: \(htmlFont.pointSize)px;
                      font-family: \(htmlFont.familyName);
                      color: \(colorHex);
                    }
                    </style>
        """
        let modified = String(format: "\(style)<p class=normal>%@</p>", self)
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
}

// MARK: - Attributed String

extension String {
    /// String을 NSAttributedString으로 변경
    /// - Parameters:
    ///   - font: UIFont
    ///   - color: UIColor
    /// - Returns: NSAttributedString
    func addAttribute(font: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        var attribute = [NSAttributedString.Key: Any]()
        if let font = font {
            attribute[.font] = font
        } else {
            attribute[.font] = STFont.regular.of(size: 14)
        }
        if let foregroundColor = color {
            attribute[.foregroundColor] = foregroundColor.cgColor
        }
        return NSAttributedString(string: self, attributes: attribute)
    }
}

extension NSAttributedString {
    /// NSAttributedString들을 연결
    /// - Parameter attributedStrings: NSAttributedString...
    /// - Returns: 연결된 하나 이상의 NSAttributedString
    static func concat(_ attributedStrings: NSAttributedString...) -> NSAttributedString {
        let returnAttString = NSMutableAttributedString()
        attributedStrings.forEach({ returnAttString.append($0) })
        return returnAttString
    }
}
