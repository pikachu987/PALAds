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

public extension String {
    
    var euckrEncoding: String {
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)
        let eucKRStringData = self.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map {byte->String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z")
                || byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z")
                || byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9")
                || byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".")
                || byte == UInt8(ascii: "-") {
                guard let unicode = UnicodeScalar(UInt32(byte)) else {
                    return ""
                }
                return String(Character(unicode))
            } else if byte == UInt8(ascii: " ") {
                return "+"
            } else {
                return String(format: "%%%02X", byte)
            }
            }.joined()
        return outputQuery
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var range: Range<Index> {
        return self.index(self.startIndex, offsetBy: 0)..<self.index(self.startIndex, offsetBy: self.count-1)
    }
    
    var parseJSON: AnyObject {
        guard let data = (self).data(using: String.Encoding.utf8) else { return "" as AnyObject }
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        } catch let error as NSError {
            print("parseJSON error \(error)")
        }
        return "" as AnyObject
    }
    
    var base64Decoding: Data {
        return Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) ?? Data()
    }
    
    var isValidEmail: Bool {
        let regEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.) {3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    var isValidUrl: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            guard let range = self.range(of: self) else { return false }
            let nsRange = NSRange(range, in: self)
            if let match = detector.firstMatch(in: self, options: [], range: nsRange) {
                return match.range.length == nsRange.length
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isValidKo: Bool {
        let regEx = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func localizedWithComment(_ comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    func substring(from: Int = 0, to: Int = -1) -> String {
        var toTmp = to
        if toTmp < 0 { toTmp = self.count + toTmp }
        let range = self.index(self.startIndex, offsetBy: from)..<self.index(self.startIndex, offsetBy: toTmp+1)
        return String(self[range])
    }
    
    func substring(from:Int = 0, length: Int) -> String {
        let range = self.index(self.startIndex, offsetBy: from)..<self.index(self.startIndex, offsetBy: from+length)
        return String(self[range])
    }
    
    func nsRange(_ words: String) -> NSRange? {
        if let range = self.range(of: words) {
            return NSRange(range, in: self)
        }
        return nil
    }
    
    func decimalFormat(_ places: Int = 6) -> String {
        guard let value = Double(self) else { return "" }
        let powValue = pow(10, Double(places))
        let intValue = Int(value * powValue)
        return "\(Double(intValue)/powValue)"
    }
    
    func toDateString(inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
    
    func matches(_ regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                guard let range = Range($0.range, in: self) else { return "" }
                return String(self[range])
                }.filter({ $0 != "" })
        } catch {
            return []
        }
    }
    
    func urlLink(_ handler: ((String) -> Void)) {
        do {
            let text = self.replacingOccurrences(of: "[\\U00010000-\\U0010FFFF]", with: "", options: String.CompareOptions.regularExpression, range: nil)
            let mentionExpression = try NSRegularExpression(pattern: "http?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?", options: .caseInsensitive)
            let matches = mentionExpression.matches(in: text, options: .init(rawValue: 0), range: NSMakeRange(0, text.count))
            for match in matches {
                let range = match.range
                let matchString = text.substring(from: range.location, length: range.length)
                if !(matchString.lowercased().hasSuffix(".png") || matchString.lowercased().hasSuffix(".jpg") || matchString.lowercased().hasSuffix(".jpeg") || matchString.lowercased().hasSuffix(".gif")) {
                    handler(matchString)
                }
            }
        } catch { }
    }

    func format(_ digits: [Int], separator: String, isRemainder: Bool = false) -> String {
        let text = self
        let cleanText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = ""
        for (index, digit) in digits.enumerated() {
            for _ in 0..<digit {
                mask.append("X")
            }
            if index != digits.count - 1 {
                mask.append(separator)
            }
        }
        var result = ""
        var index = cleanText.startIndex
        for value in mask where index < cleanText.endIndex {
            if value == "X" {
                result.append(cleanText[index])
                index = cleanText.index(after: index)
            } else {
                result.append(value)
            }
        }
        if isRemainder && digits.reduce(0, +) < self.count {
            let remainderText = self[self.index(self.startIndex, offsetBy: digits.reduce(0, +))..<self.index(self.startIndex, offsetBy: self.count)]
            result.append("\(remainderText)")
        }
        return result
    }
}
