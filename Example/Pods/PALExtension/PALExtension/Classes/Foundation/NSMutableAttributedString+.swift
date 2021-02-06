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

public extension NSMutableAttributedString {
    
    func attachment(_ name: String, color: UIColor? = nil, rect: CGRect) {
        let attachment = NSTextAttachment()
        if let color = color {
            guard let image = UIImage(named: name) else { return }
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            if let context = UIGraphicsGetCurrentContext() {
                context.setBlendMode(CGBlendMode.normal)
                context.translateBy(x: 0, y: image.size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                if let cgImage = image.cgImage {
                    context.draw(cgImage, in: rect)
                    context.clip(to: rect, mask: cgImage)
                }
                context.setFillColor(color.cgColor)
                context.fill(rect)
            }
            let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            attachment.image = colorizedImage?.withRenderingMode(.alwaysOriginal)
        } else {
            attachment.image = UIImage(named: name)
        }
        attachment.bounds = rect
        let attachmentString = NSAttributedString(attachment: attachment)
        self.append(attachmentString)
    }
}

public extension NSAttributedString {
    
    func urlLink(_ color: UIColor, handler: @escaping (([NSAttributedString.Key : Any], NSRange) -> Void)) {
        let text = self.string
        text.urlLink { (url) in
            if let range = text.range(of: url) {
                text.enumerateSubstrings(in: range, options: String.EnumerationOptions.bySentences) {
                    (substring, substringRange, _, _) in
                    
                    let attributed = [NSAttributedString.Key.link: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",
                                      NSAttributedString.Key.underlineColor: color,
                                      NSAttributedString.Key.foregroundColor: color,
                                      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single] as [NSAttributedString.Key : Any]
                    handler(attributed, NSRange(substringRange, in: text))
                }
            }
        }
    }
}
