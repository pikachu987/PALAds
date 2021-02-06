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

extension UIButton {
    open class HighlightButton: UIButton {
        open var highlightedColor: UIColor? {
            didSet {
                self.backgroundedColor = self.backgroundColor
            }
        }

        open override var backgroundColor: UIColor? {
            didSet {
                if !self.isHighlighted {
                    self.backgroundedColor = self.backgroundColor
                }
            }
        }

        open var backgroundedColor: UIColor?

        open override var isHighlighted: Bool {
            didSet {
                if let highlightedColor = self.highlightedColor {
                    if self.isHighlighted {
                        self.backgroundColor = highlightedColor
                    } else {
                        self.backgroundColor = self.backgroundedColor
                    }
                }
            }
        }

        public convenience init(highlightedColor: UIColor) {
            self.init(type: .system)
            self.highlightedColor = highlightedColor
        }
    }
}

extension UIButton {
    open class IndicatorButton: HighlightButton {
        open var text: String?
        open var image: UIImage?

        open var isShowIndicator: Bool {
            return !self.indicatorView.isHidden
        }

        open var indicatorView: UIActivityIndicatorView = {
            let indicatorView = UIActivityIndicatorView()
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
            indicatorView.color = .white
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            return indicatorView
        }()

        open func showIndicator(_ style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.gray, color: UIColor = .white, handler: (() -> Void)? = nil) {
            if self.subviews.filter({ $0 == self.indicatorView }).isEmpty {
                self.addSubview(self.indicatorView)
                self.addConstraints([
                    NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.indicatorView, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.indicatorView, attribute: .centerY, multiplier: 1, constant: 0)
                ])
            }
            self.indicatorView.style = style
            self.indicatorView.color = color
            if (self.currentTitle ?? "") != "" || self.currentImage != nil {
                self.image = self.currentImage
                self.text = self.currentTitle
                self.setImage(nil, for: .normal)
                self.setTitle("", for: .normal)
            }
            self.indicatorView.isHidden = false
            self.indicatorView.startAnimating()
            DispatchQueue.main.async {
                handler?()
            }
        }

        open func hideIndicator(_ handler: (() -> Void)? = nil) {
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
            if let image = self.image {
                self.setImage(image, for: .normal)
            }
            if let text = self.text {
                self.setTitle(text, for: .normal)
            }
            DispatchQueue.main.async {
                handler?()
            }
        }
    }
}
