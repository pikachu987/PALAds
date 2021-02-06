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

extension UITextView {
    // 플레이스홀더 텍스트뷰
    open class PlaceholderTextView: UITextView {
        open override var text: String! {
            didSet {
                self.updatePlaceholder()
            }
        }

        open var placeholderLabel: UILabel?

        private var textCount: Int {
            if self.text == nil {
                return 0
            } else {
                return self.text.count
            }
        }

        // 플레이스 홀더 텍스트
        open var placeholder: String? {
            get {
                return self.placeholderLabel?.text
            }
            set {
                if self.placeholderLabel == nil {
                    self.makePlaceholder()
                }
                self.placeholderLabel?.text = newValue
                self.placeholderLabel?.sizeToFit()
            }
        }

        // 플레이스 홀더 컬러
        open var placeholderColor: UIColor? {
            get {
                return self.placeholderLabel?.textColor ?? .lightGray
            }
            set {
                if self.placeholderLabel == nil {
                    self.makePlaceholder()
                }
                self.placeholderLabel?.textColor = newValue
            }
        }

        // 플레이스 홀더 폰트
        open var placeholderFont: UIFont? {
            get {
                return self.placeholderLabel?.font ?? self.font
            }
            set {
                if self.placeholderLabel == nil {
                    self.makePlaceholder()
                }
                self.placeholderLabel?.font = newValue
            }
        }

        // 플레이스 홀더 히든
        open var isHiddenPlaceholder: Bool {
            get {
                return self.placeholderLabel?.isHidden ?? true
            }
            set {
                if self.placeholderLabel != nil {
                    self.placeholderLabel?.isHidden = newValue
                }
            }
        }
        
        open override var textContainerInset: UIEdgeInsets {
            didSet {
                self.makePlaceholder()
            }
        }

        public convenience init() {
            self.init(frame: .zero, textContainer: nil)
        }

        public convenience init(frame: CGRect) {
            self.init(frame: frame, textContainer: nil)
        }

        public override init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)

            self.makePlaceholder()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        // 플레이스 홀더 만들기
        private func makePlaceholder() {
            let placeholder = self.placeholder
            let placeholderFont = self.placeholderFont
            let placeholderColor = self.placeholderColor

            if self.placeholderLabel != nil {
                self.placeholderLabel?.removeFromSuperview()
                self.placeholderLabel = nil
                NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
            }
            self.placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            if let placeholderLabel = self.placeholderLabel {
                placeholderLabel.text = placeholder
                placeholderLabel.isUserInteractionEnabled = false
                placeholderLabel.numberOfLines = 0
                placeholderLabel.sizeToFit()
                placeholderLabel.font = placeholderFont
                placeholderLabel.textColor = placeholderColor
                placeholderLabel.isHidden = self.textCount > 0
                
                let labelX = self.textContainer.lineFragmentPadding
                let labelY = self.textContainerInset.top - 2
                placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: self.frame.width - (labelX * 2), height: placeholderLabel.frame.height)
                placeholderLabel.setContentHuggingPriority(UILayoutPriority(248), for: .horizontal)
                placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
                
                self.addSubview(placeholderLabel)
                self.addConstraints([
                    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: placeholderLabel, attribute: .leading, multiplier: 1, constant: -labelX),
                    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: placeholderLabel, attribute: .top, multiplier: 1, constant: -labelY),
                    NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .greaterThanOrEqual, toItem: placeholderLabel, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: placeholderLabel, attribute: .bottom, multiplier: 1, constant: 0)
                ])
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange), name: UITextView.textDidChangeNotification, object: self)
            }
        }

        open override func removeFromSuperview() {
            super.removeFromSuperview()

            NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
        }

        @objc private func textDidChange() {
            self.updatePlaceholder()
        }

        func updatePlaceholder() {
            self.placeholderLabel?.isHidden = self.textCount > 0
        }
    }
}
