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

extension UIScrollView {
    // 스크롤뷰 안에 뷰 추가한 커스텀 스크롤뷰
    open class Base: UIScrollView {
        // scrollView 터치 상위 뷰에 전달
        private var isSuperviewTouches = true

        public let view: UIView = {
            let view = UIView(frame: .zero)
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        open override var backgroundColor: UIColor? {
            didSet {
                self.view.backgroundColor = self.backgroundColor
            }
        }

        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if self.isSuperviewTouches {
                self.superview?.touchesBegan(touches, with: event)
            }
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)

            self.isSuperviewTouches = true
            self.initViews()
        }

        public init() {
            super.init(frame: .zero)

            self.isSuperviewTouches = true
            self.initViews()
        }

        public init(isSuperviewTouches: Bool) {
            super.init(frame: .zero)

            self.isSuperviewTouches = isSuperviewTouches
            self.initViews()
        }

        private func initViews() {
            self.backgroundColor = .clear
            self.clipsToBounds = true

            super.addSubview(self.view)
            let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
            heightConstraint.priority = UILayoutPriority(1)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0),
                heightConstraint
            ])
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        open override func addSubview(_ view: UIView) {
            self.view.addSubview(view)
        }
    }
}
