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

public extension UILabel {
    func height(_ width: CGFloat) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = self.numberOfLines
        label.text = self.text
        label.font = self.font
        label.sizeToFit()
        return label.frame.height
    }

    func highlight(_ value: String, valueAttributes: [NSAttributedString.Key: Any], searchText: String, attributes: [NSAttributedString.Key: Any]) {
        let attributed = NSMutableAttributedString(string: value)
        attributed.addAttributes(valueAttributes, range: NSRange(location: 0, length: value.count))
        if searchText != "" {
            let regex = try? NSRegularExpression(pattern: searchText, options: .caseInsensitive)
            if let matchs = regex?.matches(in: value, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: value.count)) {
                for match in matchs {
                    attributed.addAttributes(attributes, range: match.range)
                }
            }
        }
        self.attributedText = attributed
    }
}
