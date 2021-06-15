import UIKit

public extension UIColor {
    func stringFromColor() -> String {
        guard let components = cgColor.components else { return "[0.0, 0.0, 0.0, 0.0]" }
        return "[\(components[0]), \(components[1]), \(components[2]), \(components[3])]"
    }

    class func colorFromString(string: String?, defaultColor: UIColor) -> UIColor {
        let colorString = string ?? defaultColor.stringFromColor()
        let componentsString = colorString.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                     green: CGFloat((components[1] as NSString).floatValue),
                      blue: CGFloat((components[2] as NSString).floatValue),
                     alpha: CGFloat((components[3] as NSString).floatValue))
    }

    convenience init?(hexCode: String) {
        let hex = hexCode.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        //If your string is not a hex colour String then we are returning white color. you can change this to any default colour you want.
        guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else { return nil }
        let alpha, red, green, blue: Int32
        switch hex.count {
        case 3:     (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
        case 6:     (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
        case 8:     (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
        default:    (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    static func colorRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
