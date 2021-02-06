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

// 동적 높이 변경 텍스트뷰 딜리게이트
public protocol DynamicHeightTextViewDelegate: class {
    func dynamicHeightTextViewHeight(_ textView: UITextView.DynamicHeightTextView, height: CGFloat)
    func dynamicHeightTextViewText(_ textView: UITextView.DynamicHeightTextView, text: String)
}

public extension DynamicHeightTextViewDelegate {
    func dynamicHeightTextViewHeight(_ textView: UITextView.DynamicHeightTextView, height: CGFloat) { }
    func dynamicHeightTextViewText(_ textView: UITextView.DynamicHeightTextView, text: String) { }
}

extension UITextView {
    // 동적 높이 변경 텍스트뷰
    open class DynamicHeightTextView: UITextView.PlaceholderTextView, UITextViewDelegate {
        open weak var dynamicDelegate: DynamicHeightTextViewDelegate?

        open var maxHeight: CGFloat = 0
        open var minHeight: CGFloat = 0

        // 최고 길이
        open var maxLength = 0

        // 텍스트 변경
        open override var text: String! {
            get {
                return super.text
            }
            set {
                super.text = newValue
                self.updatePlaceholder()
                self.textViewDidChange(self)
            }
        }

        // 높이
        private(set) open var height: CGFloat = 0

        public convenience init(placeholder: String, maxLength: Int = -1, minHeight: CGFloat = 30, maxHeight: CGFloat = 80) {
            self.init()

            self.delegate = self
            self.maxLength = maxLength
            self.minHeight = minHeight
            self.maxHeight = maxHeight
            self.placeholder = placeholder
            self.placeholderFont = .systemFont(ofSize: 18)
            self.isScrollEnabled = false
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.text = ""
        }
        
        open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return self.maxLength(self.maxLength, range: range, text: text)
        }

        open func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.dynamicDelegate?.dynamicHeightTextViewText(self, text: textView.text ?? "")
                self.layoutIfNeeded()
                let height = self.changeContentSize.height
                if self.height != height {
                    self.height = height
                    if self.height >= self.maxHeight {
                        self.dynamicDelegate?.dynamicHeightTextViewHeight(self, height: self.maxHeight)
                    } else if self.height <= self.minHeight {
                        self.dynamicDelegate?.dynamicHeightTextViewHeight(self, height: self.minHeight)
                    } else {
                        self.dynamicDelegate?.dynamicHeightTextViewHeight(self, height: self.height)
                    }
                }
            }
        }
    }
}
