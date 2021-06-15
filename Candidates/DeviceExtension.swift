//
//  DeviceExtension.swift
//  Student
//
//  Created by Ajiaco on 28/03/2019.
//  Copyright © 2019 TPR. All rights reserved.
//

import UIKit

public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPodTouch5"
            case "iPod7,1":                                 return "iPodTouch6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone4"
            case "iPhone4,1":                               return "iPhone4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone5s"
            case "iPhone7,2":                               return "iPhone6"
            case "iPhone7,1":                               return "iPhone6Plus"
            case "iPhone8,1":                               return "iPhone6s"
            case "iPhone8,2":                               return "iPhone6sPlus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone7Plus"
            case "iPhone8,4":                               return "iPhoneSE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone8Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhoneX"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPadAir"
            case "iPad5,3", "iPad5,4":                      return "iPadAir2"
            case "iPad6,11", "iPad6,12":                    return "iPad5"
            case "iPad7,5", "iPad7,6":                      return "iPad6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPadMini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPadMini2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPadMini3"
            case "iPad5,1", "iPad5,2":                      return "iPadMini4"
            case "iPad6,3", "iPad6,4":                      return "iPadPro9.7Inch"
            case "iPad6,7", "iPad6,8":                      return "iPadPro12.9Inch"
            case "iPad7,1", "iPad7,2":                      return "iPadPro12.9Inch2.Generation"
            case "iPad7,3", "iPad7,4":                      return "iPadPro10.5Inch"
            case "AppleTV5,3":                              return "AppleTV"
            case "AppleTV6,2":                              return "AppleTV4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "AppleTV4"
            case "AppleTV6,2": return "AppleTV4K"
            case "i386", "x86_64": return "Simulator\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
}
