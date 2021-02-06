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

import Foundation

public extension Double {
    
    var degreesToRadians: Double {
        return (self * Double.pi / 180)
    }
    
    var radiansToDegrees: Double {
        return (self * 180 / Double.pi)
    }
    
    var abs: Double {
        return self > 0 ? self : -self
    }
    
    var priceComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }

    var storage: String {
        guard self > 0 else {
            return "0 byte"
        }
        let suffixes = ["byte", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        let separator: Double = 1000
        let value = floor(log(self) / log(separator))
        let size = self / pow(separator, value)
        var numberString = ""
        if size == floor(size) {
            numberString = String(format: "%.0f", size)
        } else {
            numberString = String(format: "%.1f", size)
        }
        let suffix = suffixes[Int(value)]
        return "\(numberString) \(suffix)"
    }

    func storage(decimal: Int) -> String {
        guard self > 0 else {
            return "0 byte"
        }
        let suffixes = ["byte", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        let separator: Double = 1000
        let value = floor(log(self) / log(separator))
        let numberString = String(format: "%.\(decimal)f", self / pow(separator, value))
        let suffix = suffixes[Int(value)]
        return "\(numberString) \(suffix)"
    }
}
