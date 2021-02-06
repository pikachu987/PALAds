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

public extension UIView {
    var safe: SafeArea {
        var safeArea = SafeArea()
        if #available(iOS 11.0, *) {
            guard let keyWindow = UIApplication.shared.keyWindow else { return safeArea }
            safeArea.left = keyWindow.safeAreaInsets.left
            safeArea.right = keyWindow.safeAreaInsets.right
            safeArea.bottom = keyWindow.safeAreaInsets.bottom
        }
        safeArea.statusBarHeight = UIApplication.shared.statusBarFrame.height
        let currentViewController = UIApplication.shared.currentViewController
        safeArea.top = currentViewController?.navigationController?.navigationBar.frame.height ?? UINavigationController().navigationBar.frame.size.height
        return safeArea
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    var imageWithView: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
            return renderer.image { rendererContext in
                self.layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            if let cgContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: cgContext)
            }
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }

    static func animate(notification: Notification, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: notification.duration, delay: 0, options: notification.curve, animations: animations, completion: completion)
    }

    func animate(notification: Notification, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: notification.duration, delay: 0, options: notification.curve, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
    }

    // 라인 타입
    struct LineType: OptionSet {
        public let rawValue: Int

        static public let top = LineType(rawValue: 1 << 0)
        static public let right = LineType(rawValue: 1 << 1)
        static public let bottom = LineType(rawValue: 1 << 2)
        static public let left = LineType(rawValue: 1 << 3)

        static public let all: LineType = [.top, .right, .bottom, .left]
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    @discardableResult
    func addLineView(_ type: LineType, color: UIColor = UIColor(white: 224/255, alpha: 1), size: CGFloat = 0.8, paddingFirst: CGFloat = 0, paddingSecond: CGFloat = 0) -> UIView {
        if type.contains(.top) {
            let view = self.makeLineView(by: 102, color: color)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: paddingFirst),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: paddingSecond),
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
                ])
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size))
        }
        if type.contains(.right) {
            let view = self.makeLineView(by: 103, color: color)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: paddingFirst),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: paddingSecond),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size))
        }
        if type.contains(.bottom) {
            let view = self.makeLineView(by: 104, color: color)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: paddingFirst),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: paddingSecond),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
                ])
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size))
        }
        if type.contains(.left) {
            let view = self.makeLineView(by: 105, color: color)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: paddingFirst),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: paddingSecond),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
                ])
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size))
        }
        return self
    }

    func removeLineView(_ type: LineType) {
        if type.contains(.top) {
            self.subviews.filter({ $0.tag == 102 }).first?.removeFromSuperview()
        }
        if type.contains(.right) {
            self.subviews.filter({ $0.tag == 103 }).first?.removeFromSuperview()
        }
        if type.contains(.bottom) {
            self.subviews.filter({ $0.tag == 104}).first?.removeFromSuperview()
        }
        if type.contains(.left) {
            self.subviews.filter({ $0.tag == 105}).first?.removeFromSuperview()
        }
    }

    private func makeLineView(by tag: Int, color: UIColor) -> UIView {
        let view = LineView()
        view.tag = tag
        view.backgroundColor = color
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    class LineView: UIView {
        
    }
}
