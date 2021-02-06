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
    var horizontalCenterView: UIView {
        if let view = self.subviews.compactMap({ $0 as? CenterView }).filter({ $0.centerType == .horizontal }).first {
            return view
        } else {
            let centerView = CenterView(centerType: .horizontal)
            centerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(centerView)
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 1, constant: 0))
            centerView.addConstraint(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0))
            return centerView
        }
    }
    
    var verticalCenterView: UIView {
        if let view = self.subviews.compactMap({ $0 as? CenterView }).filter({ $0.centerType == .vertical }).first {
            return view
        } else {
            let centerView = CenterView(centerType: .vertical)
            centerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(centerView)
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
            centerView.addConstraint(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 0))
            return centerView
        }
    }
}

extension UIView {
    open class CenterView: UIView {
        public let centerType: CenterType
        
        public init(centerType: CenterType) {
            self.centerType = centerType
            super.init(frame: .zero)
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public enum CenterType {
        case horizontal
        case vertical
    }
}
