import UIKit

extension NSMutableAttributedString {
    @discardableResult
    func addFont(_ fontType: FontWeightType, range: NSRange) -> NSMutableAttributedString {
        self.addAttributes([.font: fontType.font()], range: range)
        return self
    }

    @discardableResult
    func addColor(_ color: UIColor, range: NSRange) -> NSMutableAttributedString {
        self.addAttributes([.foregroundColor: color], range: range)
        return self
    }

    func attrString() -> NSAttributedString {
        return NSAttributedString(attributedString: self)
    }
}

final class AttStrBuilder {
    typealias Attributes = [NSAttributedString.Key: Any]
    private var attrString: NSMutableAttributedString
    init(text: String = "") {
        self.attrString = NSMutableAttributedString(string: text)
    }

    func append(_ character: Character,
                attributes: Attributes) -> AttStrBuilder {
        let addedString = NSAttributedString(string: String(character), attributes: attributes)

        attrString.append(addedString)
        return self
    }

    func font(_ font: FontWeightType) -> AttStrBuilder {
        attrString.addAttributes([.font: font.font()], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }

    func color(_ color: UIColor) -> AttStrBuilder {
        attrString.addAttributes([.foregroundColor: color], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }

    func link(_ url: String) -> AttStrBuilder {
        attrString.addAttributes([.link: url], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }

    func baseline(_ offset: Int) -> AttStrBuilder {
        attrString.addAttributes([.baselineOffset: offset], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }

    func paraStyle(_ paraStyle: NSMutableParagraphStyle) -> AttStrBuilder {
        attrString.addAttributes([.paragraphStyle: paraStyle], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }

    func build() -> NSAttributedString {
        return attrString
    }

    func mutableBuild() -> NSMutableAttributedString {
        return attrString
    }
}

final class ParaStyleBuilder {
    private let paraStyle = NSMutableParagraphStyle()

    func minLineHeight(_ height: CGFloat) -> ParaStyleBuilder {
        paraStyle.minimumLineHeight = height
        return self
    }

    func lineSpacing(_ lineSpacing: CGFloat) -> ParaStyleBuilder {
        paraStyle.lineSpacing = lineSpacing
        return self
    }

    func textAlign(_ align: NSTextAlignment) -> ParaStyleBuilder {
        paraStyle.alignment = align
        return self
    }

    func build() -> NSMutableParagraphStyle {
        return paraStyle
    }
}

enum FontWeightType {
    case ultraLight(CGFloat)
    case thin(CGFloat)
    case light(CGFloat)
    case regular(CGFloat)
    case medium(CGFloat)
    case semibold(CGFloat)
    case bold(CGFloat)
    case heavy(CGFloat)
    case black(CGFloat)

    func font() -> UIFont {
        var fontSize: CGFloat = 12
        var fontWeight: UIFont.Weight = .regular

        switch self {
        case .ultraLight(let size):
            fontSize = size; fontWeight = .ultraLight
        case .thin(let size):
            fontSize = size; fontWeight = .thin
        case .light(let size):
            fontSize = size; fontWeight = .light
        case .regular(let size):
            fontSize = size; fontWeight = .regular
        case .medium(let size):
            fontSize = size; fontWeight = .medium
        case .semibold(let size):
            fontSize = size; fontWeight = .semibold
        case .bold(let size):
            fontSize = size; fontWeight = .bold
        case .heavy(let size):
            fontSize = size; fontWeight = .heavy
        case .black(let size):
            fontSize = size; fontWeight = .black
        }

        return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
}
