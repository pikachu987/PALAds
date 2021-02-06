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

public extension UIImage {
    // 이미지 회전 원복
    var fixOrientation: UIImage? {
        if self.imageOrientation == .up { return self }
        var transform = CGAffineTransform.identity

        if self.imageOrientation == .down || self.imageOrientation == .downMirrored {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }

        if self.imageOrientation == .left || self.imageOrientation == .leftMirrored {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }

        if self.imageOrientation == .right || self.imageOrientation == .rightMirrored {
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0))
        }

        if self.imageOrientation == .upMirrored || self.imageOrientation == .downMirrored {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        if self.imageOrientation == .leftMirrored || self.imageOrientation == .rightMirrored {
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        guard let cgImage = self.cgImage,
            let colorSpace = cgImage.colorSpace else { return nil }

        guard let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                  bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }

        ctx.concatenate(transform)

        if self.imageOrientation == .left ||
            self.imageOrientation == .leftMirrored ||
            self.imageOrientation == .right ||
            self.imageOrientation == .rightMirrored {
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        } else {
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        }
        guard let makeImage = ctx.makeImage() else { return nil }
        return UIImage(cgImage: makeImage)
    }

    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: .zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: newSize.width/2, y: newSize.height/2)
        context?.rotate(by: CGFloat(radians))
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func resize(_ size: CGSize, scale: CGFloat = 1, hasAlpha: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func resize(_ size: CGFloat, scale: CGFloat = 1, hasAlpha: Bool = false) -> UIImage? {
        var width: CGFloat = 0
        var height: CGFloat = 0
        if self.size.width > self.size.height {
            width = size
            height = width*self.size.height/self.size.width
        } else {
            height = size
            width = height*self.size.width/self.size.height
        }
        return self.resize(CGSize(width: width, height: height), scale: scale, hasAlpha: hasAlpha)
    }
    
    func repercentage(_ percentage: CGFloat) -> UIImage {
        guard let data = self.jpegData(compressionQuality: percentage) else { return UIImage() }
        return UIImage(data: data) ?? UIImage()
    }
    
    func colorRendering(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setBlendMode(CGBlendMode.normal)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            if let cgImage = self.cgImage {
                context.draw(cgImage, in: rect)
                context.clip(to: rect, mask: cgImage)
            }
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorizedImage?.withRenderingMode(.alwaysOriginal)
    }

    func pixelColor(_ pos: CGPoint) -> UIColor {
        guard let pixelData = self.cgImage?.dataProvider?.data else{ return .clear }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    func crop(_ rect: CGRect, scale: CGFloat = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width / scale, height: rect.size.height / scale), true, 0.0)
        self.draw(at: CGPoint(x: -rect.origin.x / scale, y: -rect.origin.y / scale))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage
    }
}
