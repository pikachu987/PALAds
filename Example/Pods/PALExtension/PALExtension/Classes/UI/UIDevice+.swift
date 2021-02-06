//Copyright (c) 2021 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit

public extension UIDevice {
    // UIDeviceType
    enum DeviceType: String {
        case iPhone
        case iPad
        case iPod
        case appleTV
        case simulator
        case unknown
    }

    // UIDeviceModelType
    enum DeviceModelType: String {
        /* iPhone */
        case iPhoneUnknown
        case iPhone2G
        case iPhone3G
        case iPhone3GS
        case iPhone4
        case iPhone4S
        case iPhone5
        case iPhone5C
        case iPhone5S
        case iPhone6
        case iPhone6Plus
        case iPhone6S
        case iPhone6SPlus
        case iPhoneSE
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXS
        case iPhoneXS_Max
        case iPhoneXR
        case iPhone11
        case iPhone11Pro
        case iPhone11Pro_Max
        case iPhoneSE2
        case iPhone12Mini
        case iPhone12
        case iPhone12Pro
        case iPhone12Pro_Max

        /* iPad */
        case iPadUnknown
        case iPad1
        case iPad2
        case iPad3
        case iPad4
        case iPad5
        case iPad6
        case iPad7
        case iPad8
        case iPadAir
        case iPadAir2
        case iPadAir3
        case iPadAir4
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadMini5

        /* iPadPro */
        case iPadPro9_7Inch
        case iPadPro12_9Inch
        case iPadPro10_5Inch
        case iPadPro12_9Inch2
        case iPadPro11_0Inch
        case iPadPro12_9Inch3
        case iPadPro11_0Inch2
        case iPadPro12_9Inch4

        /* iPod */
        case iPodTouchUnknown
        case iPodTouch1Gen
        case iPodTouch2Gen
        case iPodTouch3Gen
        case iPodTouch4Gen
        case iPodTouch5Gen
        case iPodTouch6Gen
        case iPodTouch7Gen

        /* appleTV */
        case appleTVUnknown
        case appleTV5

        /* simulator  */
        case simulator

        /* unknown */
        case unknown
    }
}

private extension UIDevice {
    func getModelType(_ machineString: String) -> DeviceModelType {
        switch machineString {
        /* iPhone */
        case "iPhone1,1":                                return .iPhone2G
        case "iPhone1,2":                                return .iPhone3G
        case "iPhone2,1":                                return .iPhone3GS
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4S
        case "iPhone5,1", "iPhone5,2":                   return .iPhone5
        case "iPhone5,3", "iPhone5,4":                   return .iPhone5C
        case "iPhone6,1", "iPhone6,2":                   return .iPhone5S
        case "iPhone7,2":                                return .iPhone6
        case "iPhone7,1":                                return .iPhone6Plus
        case "iPhone8,1":                                return .iPhone6S
        case "iPhone8,2":                                return .iPhone6SPlus
        case "iPhone8,3", "iPhone8,4":                   return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                   return .iPhone7
        case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                 return .iPhone8
        case "iPhone10,2", "iPhone10,5":                 return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                 return .iPhoneX
        case "iPhone11,2":                               return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                 return .iPhoneXS_Max
        case "iPhone11,8":                               return .iPhoneXR
        case "iPhone12,1":                               return .iPhone11
        case "iPhone12,3":                               return .iPhone11Pro
        case "iPhone12,5":                               return .iPhone11Pro_Max
        case "iPhone12,8":                               return .iPhoneSE2
        case "iPhone13,1":                               return .iPhone12Mini
        case "iPhone13,2":                               return .iPhone12
        case "iPhone13,3":                               return .iPhone12Pro
        case "iPhone13,4":                               return .iPhone12Pro_Max

        /* iPad */
        case "iPad1,1", "iPad1,2":                       return .iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":            return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":            return .iPad4
        case "iPad6,11", "iPad6,12":                     return .iPad5
        case "iPad7,5", "iPad7,6":                       return .iPad6
        case "iPad7,11", "iPad7,12":                     return .iPad7
        case "iPad11,6", "iPad11,7":                     return .iPad8
        case "iPad4,1", "iPad4,2", "iPad4,3":            return .iPadAir
        case "iPad5,3", "iPad5,4":                       return .iPadAir2
        case "iPad11,3", "iPad11,4":                     return .iPadAir3
        case "iPad13,1", "iPad13,2":                     return .iPadAir4
        case "iPad2,5", "iPad2,6", "iPad2,7":            return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":            return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":            return .iPadMini3
        case "iPad5,1", "iPad5,2":                       return .iPadMini4
        case "iPad11,1", "iPad11,2":                     return .iPadMini5

        /* iPadPro */
        case "iPad6,3", "iPad6,4":                       return .iPadPro9_7Inch
        case "iPad6,7", "iPad6,8":                       return .iPadPro12_9Inch
        case "iPad7,1", "iPad7,2":                       return .iPadPro12_9Inch2
        case "iPad7,3", "iPad7,4":                       return .iPadPro10_5Inch
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11_0Inch
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12_9Inch3
        case "iPad8,9", "iPad8,10":                      return .iPadPro11_0Inch2
        case "iPad8,11", "iPad8,12":                     return .iPadPro12_9Inch4

        /* iPod */
        case "iPod1,1":                                  return .iPodTouch1Gen
        case "iPod2,1":                                  return .iPodTouch2Gen
        case "iPod3,1":                                  return .iPodTouch3Gen
        case "iPod4,1":                                  return .iPodTouch4Gen
        case "iPod5,1":                                  return .iPodTouch5Gen
        case "iPod7,1":                                  return .iPodTouch6Gen
        case "iPod9,1":                                  return .iPodTouch7Gen

        /* appleTV */
        case "AppleTV5,3":                               return .appleTV5

        /* Simulator */
        case "i386", "x86_64":                           return .simulator

        default:
            if machineString.lowercased().contains("ipad") {
                return .iPadUnknown
            } else if machineString.lowercased().contains("iphone") {
                return .iPhoneUnknown
            } else if machineString.lowercased().contains("ipod") {
                return .iPodTouchUnknown
            } else if machineString.lowercased().contains("appletv") {
                return .appleTVUnknown
            }
            return .unknown
        }
    }
}

public extension UIDevice {
    static var deviceModelType: DeviceModelType {
        return UIDevice.current.deviceModelType
    }
    
    static var deviceSimulatorModelType: DeviceModelType {
        return UIDevice.current.deviceSimulatorModelType
    }

    static var deviceType: DeviceType {
        return UIDevice.current.deviceType
    }
    
    static var deviceSimulatorType: DeviceType {
        return UIDevice.current.deviceSimulatorType
    }
    
    static var machineString: String {
        return UIDevice.current.machineString
    }

    var deviceModelType: DeviceModelType {
        return self.getModelType(self.machineString)
    }
    
    var deviceSimulatorModelType: DeviceModelType {
        #if targetEnvironment(simulator)
        if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return self.getModelType(dir)
        } else {
            return .unknown
        }
        #else
        return self.deviceModelType
        #endif
    }

    var deviceType: DeviceType {
        return self.deviceType(machineString: self.machineString)
    }
    
    var deviceSimulatorType: DeviceType {
        #if targetEnvironment(simulator)
        if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return self.deviceType(machineString: dir)
        } else {
            return .unknown
        }
        #else
        return self.deviceType
        #endif
    }

    var machineString: String {
        var systemInfo = utsname()
        _ = uname(&systemInfo)
        let machineString = Mirror(reflecting: systemInfo.machine).children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return machineString
    }
    
    private func deviceType(machineString: String) -> DeviceType {
        if machineString.lowercased().contains("iPhone".lowercased()) {
            return .iPhone
        } else if machineString.lowercased().contains("iPad".lowercased()) {
            return .iPad
        } else if machineString.lowercased().contains("iPod".lowercased()) {
            return .iPod
        } else if machineString.lowercased().contains("AppleTV".lowercased()) {
            return .appleTV
        } else if machineString == "i386" || machineString == "x86_64" {
            return .simulator
        } else {
            return .unknown
        }
    }
}
