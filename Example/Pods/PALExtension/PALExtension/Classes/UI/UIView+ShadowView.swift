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

extension UIView {
    open class ShadowView: UIView {
        open var shadowRadius: CGFloat = 2.0 {
            didSet {
                self.update()
            }
        }

        open var shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0) {
            didSet {
                self.update()
            }
        }

        open var shadowOpacity: CGFloat = 0.7 {
            didSet {
                self.update()
            }
        }

        open var shadowColor: UIColor = UIColor(light: UIColor(white: 0, alpha: 0.2), dark: UIColor(white: 0, alpha: 0.2)) {
            didSet {
                self.update()
            }
        }

        open override var backgroundColor: UIColor? {
            didSet {
                self.update()
            }
        }

        open var view: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.isUserInteractionEnabled = false
            view.backgroundColor = .clear
            return view
        }()

        private var shadowLayer: CAShapeLayer?
        private var isFrameSet = false

        public init() {
            super.init(frame: .zero)
            self.setEntity()
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.setEntity()
        }

        public init(shadowColor: UIColor, shadowOpacity: CGFloat = 0.7, shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0), shadowRadius: CGFloat = 2.0) {
            super.init(frame: .zero)
            self.shadowColor = shadowColor
            self.shadowOpacity = shadowOpacity
            self.shadowOffset = shadowOffset
            self.shadowRadius = shadowRadius
            self.setEntity()
        }

        private func setEntity() {
            self.isUserInteractionEnabled = false
            self.backgroundColor = .white

            super.addSubview(self.view)

            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            ])
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        open override func layoutSubviews() {
            super.layoutSubviews()

            self.isFrameSet = true
            self.update()
        }

        open func update() {
            if !self.isFrameSet { return }
            if self.shadowLayer == nil {
                self.shadowLayer = CAShapeLayer()
            } else {
                self.shadowLayer?.removeFromSuperlayer()
            }
            guard let shadowLayer = self.shadowLayer else { return }
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.view.layer.cornerRadius).cgPath
            shadowLayer.shadowColor = self.shadowColor.cgColor
            shadowLayer.shadowOffset = self.shadowOffset
            shadowLayer.shadowOpacity = Float(self.shadowOpacity)
            shadowLayer.shadowRadius = self.shadowRadius
            shadowLayer.cornerRadius = self.view.layer.cornerRadius
            shadowLayer.fillColor = self.backgroundColor?.cgColor
            self.layer.insertSublayer(shadowLayer, at: 0)
        }

        open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            if #available(iOS 13.0, *) {
                self.update()
            }
        }

        open override func addSubview(_ view: UIView) {
            self.view.addSubview(view)
        }
    }
}
