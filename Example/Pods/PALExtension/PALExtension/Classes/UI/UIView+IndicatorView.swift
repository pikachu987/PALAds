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
    private static var window: UIWindow? {
        if let window = UIApplication.shared.keyWindow {
            return window
        } else {
            let windows = UIApplication.shared.windows
            for window in windows {
                return window
            }
            return nil
        }
    }

    static var isIndicator: Bool {
        return self.window?.isIndicator ?? false
    }

    static var indicators: [IndicatorView] {
        return self.window?.indicators ?? []
    }

    @discardableResult
    static func indicatorAdd(_ color: UIColor, size: CGFloat = 44, dimColor: UIColor? = nil) -> IndicatorView {
        return self.window?.indicatorAdd(color, size: size, dimColor: dimColor) ?? IndicatorView(activitySize: size, isDim: dimColor != nil)
    }
    
    static func indicatorsProgress(_ progress: Double, decimalPlaces: Int = 1, textColor: UIColor = .white) {
        self.window?.indicatorsProgress(progress, decimalPlaces: decimalPlaces, textColor: textColor)
    }

    static func indicatorsRemove() {
        self.window?.indicatorsRemove()
    }

    var isIndicator: Bool {
        return !self.subviews.compactMap({ $0 as? IndicatorView }).isEmpty
    }

    var indicators: [IndicatorView] {
        return self.subviews.compactMap({ $0 as? IndicatorView })
    }

    @discardableResult
    func indicatorAdd(_ color: UIColor, size: CGFloat = 44, dimColor: UIColor? = nil) -> IndicatorView {
        let containerView = IndicatorView(activitySize: size, isDim: dimColor != nil)
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
        containerView.activityView.startAndShowAnimating(color, size: CGSize(width: size, height: size))
        return containerView
    }

    // 프로그래스
    func indicatorsProgress(_ progress: Double, decimalPlaces: Int = 1, textColor: UIColor = .white) {
        self.indicators.forEach({
            $0.progress(progress, decimalPlaces: decimalPlaces, textColor: textColor)
        })
    }

    // 지우기
    func indicatorsRemove() {
        self.indicators.forEach({
            $0.remove()
        })
    }
}

extension UIView {
    open class IndicatorView: UIView {
        public let activityView: IndicatorActivityView
        private let isDim: Bool
        private let activitySize: CGFloat

        public init(activitySize: CGFloat, isDim: Bool) {
            self.activitySize = activitySize
            self.isDim = isDim
            self.activityView = IndicatorActivityView(frame: CGRect(x: 0, y: 0, width: self.activitySize, height: self.activitySize))
            super.init(frame: .zero)
            self.setupActivity()
        }

        required public init?(coder: NSCoder) {
            self.activitySize = 44
            self.isDim = false
            self.activityView = IndicatorActivityView(frame: CGRect(x: 0, y: 0, width: self.activitySize, height: self.activitySize))
            super.init(coder: coder)
            self.setupActivity()
        }

        private func setupActivity() {
            self.activityView.translatesAutoresizingMaskIntoConstraints = false
            self.activityView.updateSize(self.activitySize)
            
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
        }
        
        open func remove() {
            self.subviews.compactMap({ $0 as? IndicatorActivityView }).forEach({
                $0.stopAndHideAnimating()
                $0.removeFromSuperview()
            })
            self.removeFromSuperview()
        }
        
        open func progress(_ progress: Double, decimalPlaces: Int = 1, textColor: UIColor = .white) {
            self.activityView.progress(progress, decimalPlaces: decimalPlaces, textColor: textColor)
        }
    }

    // 인디게이트 뷰
    open class IndicatorActivityView: UIView {
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

        private var size: CGFloat = 44

        open func updateSize(_ size: CGFloat) {
            self.layer.cornerRadius = size/2
            self.size = size
        }

        // 프로그래스
        open func progress(_ progress: Double, decimalPlaces: Int, textColor: UIColor) {
            self.label.text = String(format: "%.\(decimalPlaces)f", progress).appending("%")
            self.label.textColor = textColor
        }

        // 애니메이션 시작
        open func startAndShowAnimating(_ color: UIColor = .black, size: CGSize) {
            self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            let size = CGSize(width: self.size, height: self.size)
            let beginTime: Double = 0.5
            let strokeStartDuration: Double = 1.2
            let strokeEndDuration: Double = 0.7

            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.byValue = Float.pi * 2
            #if swift(>=4.2)
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            #else
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            #endif

            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.duration = strokeEndDuration
            strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            strokeEndAnimation.fromValue = 0
            strokeEndAnimation.toValue = 1

            let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
            strokeStartAnimation.duration = strokeStartDuration
            strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            strokeStartAnimation.fromValue = 0
            strokeStartAnimation.toValue = 1
            strokeStartAnimation.beginTime = beginTime

            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
            groupAnimation.duration = strokeStartDuration + beginTime
            groupAnimation.repeatCount = .infinity
            groupAnimation.isRemovedOnCompletion = false
            #if swift(>=4.2)
            groupAnimation.fillMode = .forwards
            #else
            groupAnimation.fillMode = kCAFillModeForwards
            #endif

            let shapeLayer: CAShapeLayer = CAShapeLayer()
            let path: UIBezierPath = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: -(.pi / 2),
                        endAngle: .pi + .pi / 2,
                        clockwise: true)
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 2
            shapeLayer.backgroundColor = nil
            shapeLayer.path = path.cgPath
            shapeLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            let frame = CGRect(
                x: (self.layer.bounds.width - size.width) / 2,
                y: (self.layer.bounds.height - size.height) / 2,
                width: size.width,
                height: size.height
            )

            shapeLayer.frame = frame
            shapeLayer.add(groupAnimation, forKey: "animation")
            self.layer.addSublayer(shapeLayer)
        }

        // 애니메이션 중지
        open func stopAndHideAnimating() {
            self.layer.sublayers?.forEach({ $0.removeAllAnimations() })
            self.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
            self.layer.sublayers = nil
        }
    }
}
