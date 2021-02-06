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

public extension UIColor {
    
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init(dynamicProvider: { (collection) -> UIColor in
                return collection.userInterfaceStyle == .light ? light : dark
            })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }

    private convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    var red: CGFloat { return CIColor(color: self).red }
    var green: CGFloat { return CIColor(color: self).green }
    var blue: CGFloat { return CIColor(color: self).blue }
    var alpha: CGFloat { return CIColor(color: self).alpha }
    
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }

    func equal(color: UIColor) -> Bool {
        var lhs: UIColor = self
        var rhs: UIColor = color
        if #available(iOS 13.0, *) {
            lhs = self.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
            rhs = color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        }
        var leftRed: CGFloat = 0
        var leftGreen: CGFloat = 0
        var leftBlue: CGFloat = 0
        var leftAlpha: CGFloat = 0

        var rightRed: CGFloat = 0
        var rightGreen: CGFloat = 0
        var rightBlue: CGFloat = 0
        var rightAlpha: CGFloat = 0

        lhs.getRed(&leftRed, green: &leftGreen, blue: &leftBlue, alpha: &leftAlpha)
        rhs.getRed(&rightRed, green: &rightGreen, blue: &rightBlue, alpha: &rightAlpha)

        if leftRed == rightRed && leftGreen == rightGreen && leftBlue == rightBlue && leftAlpha == rightAlpha {
            return true
        } else {
            return false
        }
    }

    func image(_ size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil  }
        UIGraphicsEndImageContext()
        return image
    }
}


public extension UIColor {
    var hsv: HSV {
        return UIColor.hsv(self)
    }
    
    static func hsv(red: CGFloat, green: CGFloat, blue: CGFloat) -> HSV {
        let min = red < green ? (red < blue ? red : blue) : (green < blue ? green : blue)
        let max = red > green ? (red > blue ? red : blue) : (green > blue ? green : blue)
        
        let value = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(hue: 0, saturation: 0, value: max) }
        guard max > 0 else { return HSV(hue: -1, saturation: 0, value: value) }
        let saturation = delta / max
        
        let hueSet: (CGFloat, CGFloat) -> CGFloat = { max, delta -> CGFloat in
            if red == max { return (green - blue)/delta } // between yellow & magenta
            else if green == max { return 2 + (blue - red)/delta } // between cyan & yellow
            else { return 4 + (red - green)/delta } // between magenta & cyan
        }
        let hue = hueSet(max, delta) * 60 // degrees
        return HSV(hue: (hue < 0 ? hue+360 : hue) , saturation: saturation, value: value)
    }

    static func hsv(_ color: UIColor) -> HSV {
        return hsv(red: color.red, green: color.green, blue: color.blue)
    }
}

public extension UIColor {
    private convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    struct HSV {
        public let hue: CGFloat // 색상
        public let saturation: CGFloat // 채도
        public let value: CGFloat //명도

        public var rgb: UIColor {
            return HSV.rgb(self)
        }
        
        public var point: CGPoint {
            return CGPoint(x: CGFloat(hue/360), y: CGFloat(value))
        }
        
        public static func color(_ hue: CGFloat, saturation: CGFloat, value: CGFloat) -> UIColor {
            if saturation == 0 { return UIColor(red: value, green: value, blue: value) }
            
            let angle = (hue >= 360 ? 0 : hue)
            let sector = angle / 60
            let i = floor(sector)
            let f = sector - i
            
            let p = value * (1 - saturation)
            let q = value * (1 - (saturation * f))
            let t = value * (1 - (saturation * (1 - f)))
            
            switch(i) {
            case 0:
                return UIColor(red: value, green: t, blue: p)
            case 1:
                return UIColor(red: q, green: value, blue: p)
            case 2:
                return UIColor(red: p, green: value, blue: t)
            case 3:
                return UIColor(red: p, green: q, blue: value)
            case 4:
                return UIColor(red: t, green: p, blue: value)
            default:
                return UIColor(red: value, green: p, blue: q)
            }
        }
        
        public static func rgb(_ hsv: HSV) -> UIColor {
            return self.color(hsv.hue, saturation: hsv.saturation, value: hsv.value)
        }
    }
}
