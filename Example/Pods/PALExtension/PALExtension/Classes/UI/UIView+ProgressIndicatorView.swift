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

// 뷰 + 인디게이터 뷰
public extension UIView {
    static var isProgressIndicator: Bool {
        return UIApplication.shared.currentWindow?.isProgressIndicator ?? false
    }

    static var progressIndicators: [ProgressIndicatorView] {
        return UIApplication.shared.currentWindow?.progressIndicators ?? []
    }

    @discardableResult
    static func progressIndicatorAdd(_ size: CGFloat = 44, dimColor: UIColor? = nil) -> ProgressIndicatorView {
        return UIApplication.shared.currentWindow?.progressIndicatorAdd(size, dimColor: dimColor) ?? ProgressIndicatorView(activitySize: size, isDim: dimColor != nil)
    }
    
    var isProgressIndicator: Bool {
        return !self.subviews.compactMap({ $0 as? ProgressIndicatorView }).isEmpty
    }

    var progressIndicators: [ProgressIndicatorView] {
        return self.subviews.compactMap({ $0 as? ProgressIndicatorView })
    }

    @discardableResult
    func progressIndicatorAdd(_ size: CGFloat = 44, dimColor: UIColor? = nil) -> ProgressIndicatorView {
        let containerView = ProgressIndicatorView(activitySize: size, isDim: dimColor != nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isUserInteractionEnabled = true
        self.addSubview(containerView)
        
        if let dimColor = dimColor {
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
            containerView.backgroundColor = dimColor
        } else {
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            containerView.addConstraints([
                NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size),
                NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size)
            ])
            containerView.backgroundColor = .clear
        }
        containerView.activityView.addProgressIndicator()
        return containerView
    }
}

extension UIView {
    open class ProgressIndicatorView: UIView {
        open var progressLayer: CAShapeLayer {
            return self.activityView.progressLayer
        }

        open var trackLayer: CAShapeLayer {
            return self.activityView.trackLayer
        }

        open var progressColor: UIColor? {
            get {
                return self.activityView.progressColor
            }
            set {
                self.activityView.progressColor = newValue
            }
        }

        open var trackColor: UIColor? {
            get {
                return self.activityView.trackColor
            }
            set {
                self.activityView.trackColor = newValue
            }
        }

        open var progressLineWidth: CGFloat {
            get {
                return self.activityView.progressLineWidth
            }
            set {
                self.activityView.progressLineWidth = newValue
            }
        }

        open var trackLineWidth: CGFloat {
            get {
                return self.activityView.trackLineWidth
            }
            set {
                self.activityView.trackLineWidth = newValue
            }
        }

        open var progress: CGFloat {
            get {
                return self.activityView.progress
            }
            set {
                self.activityView.progress = newValue
            }
        }

        open var isProgress: Bool {
            return self.activityView.isProgress
        }
        
        public let activityView: CircleProgressView
        private let isDim: Bool
        private let activitySize: CGFloat

        public init(activitySize: CGFloat, isDim: Bool) {
            self.activitySize = activitySize
            self.isDim = isDim
            self.activityView = CircleProgressView(frame: CGRect(x: 0, y: 0, width: self.activitySize, height: self.activitySize))
            super.init(frame: .zero)
            self.setupActivity()
        }

        required public init?(coder: NSCoder) {
            self.activitySize = 44
            self.isDim = false
            self.activityView = CircleProgressView(frame: CGRect(x: 0, y: 0, width: self.activitySize, height: self.activitySize))
            super.init(coder: coder)
            self.setupActivity()
        }

        private func setupActivity() {
            self.activityView.translatesAutoresizingMaskIntoConstraints = false
            self.activityView.frame = CGRect(x: 0, y: 0, width: self.activitySize, height: self.activitySize)
            
            self.addSubview(self.activityView)
            if self.isDim {
                self.addConstraints([
                    NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.activityView, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.activityView, attribute: .centerY, multiplier: 1, constant: 0)
                ])
                self.activityView.addConstraints([
                    NSLayoutConstraint(item: self.activityView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.activitySize),
                    NSLayoutConstraint(item: self.activityView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.activitySize)
                ])
            } else {
                self.addConstraints([
                    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.activityView, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.activityView, attribute: .trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.activityView, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.activityView, attribute: .bottom, multiplier: 1, constant: 0)
                ])
            }

            self.trackLineWidth = 2
            self.trackColor = UIColor(white: 248/255, alpha: 1)
            self.progressLineWidth = 2
            self.progressColor = .black
            
            self.activityView.layer.cornerRadius = self.activitySize / 2
            self.activityView.backgroundColor = .clear
        }
        
        open func remove() {
            self.subviews.compactMap({ $0 as? CircleProgressView }).forEach({
                $0.removeProgressIndicator()
                $0.removeFromSuperview()
            })
            self.removeFromSuperview()
        }
        
        open func progress(_ progress: Double, decimalPlaces: Int, textColor: UIColor) {
            self.progress = CGFloat(progress)
            self.activityView.label.text = String(format: "%.\(decimalPlaces)f", progress).appending("%")
            self.activityView.label.textColor = textColor
        }
    }

    open class CircleProgressView: UIView {
        open lazy var label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = ""
            label.font = .systemFont(ofSize: 9)
            self.backgroundColor = UIColor(white: 255/255, alpha: 0.01)
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: label, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0),
            ])
            return label
        }()

        open var progressLayer: CAShapeLayer = {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeEnd = 0.0
            return layer
        }()

        open var trackLayer: CAShapeLayer = {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeEnd = 1.0
            return layer
        }()

        open var progressColor: UIColor? {
            get {
                if let color = self.progressLayer.strokeColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                self.progressLayer.strokeColor = newValue?.cgColor
            }
        }

        open var trackColor: UIColor? {
            get {
                if let color = self.trackLayer.strokeColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                self.trackLayer.strokeColor = newValue?.cgColor
            }
        }

        open var progressLineWidth: CGFloat {
            get {
                return self.progressLayer.lineWidth
            }
            set {
                self.progressLayer.lineWidth = newValue
            }
        }

        open var trackLineWidth: CGFloat {
            get {
                return self.trackLayer.lineWidth
            }
            set {
                self.trackLayer.lineWidth = newValue
            }
        }

        open var progress: CGFloat {
            get {
                return self.progressLayer.strokeEnd * 100
            }
            set {
                self.progressLayer.strokeEnd = newValue / 100
            }
        }

        open var isProgress: Bool {
            guard let sublayers = self.layer.sublayers else { return false }
            if sublayers.contains(self.trackLayer) && sublayers.contains(self.progressLayer) {
                return true
            }
            return false
        }

        open func addProgressIndicator() {
            self.removeProgressIndicator()
            self.layoutIfNeeded()
            self.layer.cornerRadius = self.frame.size.width/2
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.width/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)

            self.layer.addSublayer(self.trackLayer)
            self.layer.addSublayer(self.progressLayer)

            self.trackLayer.path = circlePath.cgPath
            self.trackLayer.strokeColor = self.trackColor?.cgColor
            self.trackLayer.lineWidth = self.trackLineWidth

            self.progressLayer.path = circlePath.cgPath
            self.progressLayer.strokeColor = self.progressColor?.cgColor
            self.progressLayer.lineWidth = self.trackLineWidth
            self.progressLayer.strokeEnd = 0
        }

        open func removeProgressIndicator() {
            guard let sublayers = self.layer.sublayers else { return }
            if sublayers.contains(self.trackLayer) {
                self.trackLayer.removeFromSuperlayer()
            }

            if sublayers.contains(self.progressLayer) {
                self.progressLayer.removeFromSuperlayer()
                self.progressLayer.strokeEnd = 0
            }
        }

        open func setProgressWithAnimation(duration: TimeInterval, value: Float) {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = self.progressLayer.strokeEnd
            animation.toValue = value / 100
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            self.progressLayer.strokeEnd = CGFloat(value)
            self.progressLayer.add(animation, forKey: "animateprogress")
        }

        open func progressText(_ progress: Double, decimalPlaces: Int, textColor: UIColor) {
            self.progress = CGFloat(progress)
            self.label.text = String(format: "%.\(decimalPlaces)f", progress).appending("%")
            self.label.textColor = textColor
        }
    }
}
