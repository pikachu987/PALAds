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
    open class GestureButton: UIButton {
        public let gestureView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = false
            return view
        }()

        open var gestureColor: UIColor = UIColor(light: UIColor(white: 240/255, alpha: 1), dark: UIColor(white: 40/255, alpha: 1)) {
            didSet {
                self.gestureView.backgroundColor = self.gestureColor
            }
        }

        open var gestureWidth: CGFloat = 60 {
            didSet {
                self.gestureView.constraints.filter({ $0.firstAttribute == .width }).first?.constant = self.gestureWidth
            }
        }

        open var gestureHeight: CGFloat = 8 {
            didSet {
                self.gestureView.constraints.filter({ $0.firstAttribute == .height }).first?.constant = self.gestureHeight
                self.gestureView.layer.cornerRadius = self.gestureHeight / 2
            }
        }

        open var gesturePadding: CGFloat = 8 {
            didSet {
                self.constraints.filter({ $0.firstAttribute == .top && $0.secondAttribute == .top }).first?.constant = -self.gesturePadding
                self.constraints.filter({ $0.firstAttribute == .bottom && $0.secondAttribute == .bottom }).first?.constant = self.gesturePadding
            }
        }

        open override var isHighlighted: Bool {
            didSet {
                if self.isHighlighted {
                    self.gestureView.backgroundColor = UIColor(light: UIColor(white: 218/255, alpha: 1), dark: UIColor(white: 70/255, alpha: 1))
                } else {
                    self.gestureView.backgroundColor = UIColor(light: UIColor(white: 240/255, alpha: 1), dark: UIColor(white: 40/255, alpha: 1))
                }
            }
        }

        public convenience init() {
            self.init(type: .system)
            
            self.clipsToBounds = true

            self.addSubview(self.gestureView)
            
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.gestureView, attribute: .top, multiplier: 1, constant: -self.gesturePadding),
                NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.gestureView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.gestureView, attribute: .bottom, multiplier: 1, constant: self.gesturePadding)
            ])
            
            self.gestureView.addConstraints([
                NSLayoutConstraint(item: self.gestureView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.gestureWidth),
                NSLayoutConstraint(item: self.gestureView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.gestureHeight)
            ])
            
            self.gestureView.backgroundColor = self.gestureColor
            self.gestureView.layer.cornerRadius = self.gestureHeight / 2
        }
    }
}


extension UIView {
    open class PopupDimView: UIView {
        public let backgroundView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        public let emptyButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        public let popupView: PopupView = {
            let view = PopupView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        public let emptyView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        open var backgroundViewColor: UIColor = UIColor(white: 0/255, alpha: 0.65) {
            didSet {
                self.backgroundView.backgroundColor = self.backgroundViewColor
            }
        }
        
        public var gestureButton: GestureButton {
            return self.popupView.gestureButton
        }

        public var navigationBar: UINavigationBar {
            return self.popupView.navigationBar
        }

        public var view: UIView {
            return self.popupView.view
        }

        open var gestureButtonColor: UIColor {
            get {
                return self.popupView.gestureButtonColor
            }
            set {
                self.popupView.gestureButtonColor = newValue
            }
        }

        open var gestureButtonWidth: CGFloat {
            get {
                return self.popupView.gestureButtonWidth
            }
            set {
                self.popupView.gestureButtonWidth = newValue
            }
        }
        
        open var gestureButtonHeight: CGFloat {
            get {
                return self.popupView.gestureButtonHeight
            }
            set {
                self.popupView.gestureButtonHeight = newValue
            }
        }

        open var gesturePadding: CGFloat {
            get {
                return self.popupView.gesturePadding
            }
            set {
                self.popupView.gesturePadding = newValue
            }
        }

        open var corners: UIRectCorner {
            get {
                return self.popupView.corners
            }
            set {
                self.popupView.corners = newValue
            }
        }

        open var cornerRadius: CGFloat {
            get {
                return self.popupView.cornerRadius
            }
            set {
                self.popupView.cornerRadius = newValue
            }
        }
        
        open var isNavigationBar: Bool {
            get {
                return self.popupView.isNavigationBar
            }
            set {
                self.popupView.isNavigationBar = newValue
            }
        }

        open var navigationBarTintColor: UIColor {
            get {
                return self.popupView.navigationBarTintColor
            }
            set {
                self.popupView.navigationBarTintColor = newValue
            }
        }
        
        open var viewColor: UIColor {
            get {
                return self.popupView.viewColor
            }
            set {
                self.popupView.viewColor = newValue
                self.emptyView.backgroundColor = newValue
            }
        }
        
        open var isShow: Bool {
            get {
                return (self.constraints.filter({ $0.firstAttribute == .height }).first?.constant ?? 0) != 0
            }
            set {
                self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = newValue ? self.height : 0
            }
        }
        
        open var viewHeight: CGFloat {
            get {
                return self.popupView.viewHeight
            }
            set {
                self.popupView.viewHeight = newValue
            }
        }

        open var isDynamicGesture: Bool {
            get {
                return self.popupView.isDynamicGesture
            }
            set {
                self.popupView.isDynamicGesture = newValue
            }
        }
        
        open var height: CGFloat = UIScreen.main.bounds.height
        

        public init() {
            super.init(frame: .zero)
            
            self.clipsToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .clear

            self.addSubview(self.backgroundView)
            self.addSubview(self.emptyButton)
            self.addSubview(self.emptyView)
            self.addSubview(self.popupView)

            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
            ])
            
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.emptyButton, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.emptyButton, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.emptyButton, attribute: .top, multiplier: 1, constant: 0).priority(800),
                NSLayoutConstraint(item: self.popupView, attribute: .top, relatedBy: .equal, toItem: self.emptyButton, attribute: .bottom, multiplier: 1, constant: 0)
            ])

            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.backgroundView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.backgroundView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.backgroundView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.backgroundView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
            
            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.popupView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.popupView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.popupView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
            
            self.addConstraints([
                NSLayoutConstraint(item: self.popupView, attribute: .height, relatedBy: .equal, toItem: self.emptyView, attribute: .height, multiplier: 1.5, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.emptyView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.emptyView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.emptyView, attribute: .bottom, multiplier: 1, constant: 0)
            ])

            self.backgroundView.backgroundColor = self.backgroundViewColor
            self.emptyView.backgroundColor = self.viewColor
            self.popupView.isShow = true
            self.emptyButton.addTarget(self, action: #selector(self.backgroundTap(_:)), for: .touchUpInside)
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open func updateCorner() {
            self.popupView.updateCorner()
        }
        
        open func show(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            self.popupView.contentShow(0)
            self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = self.height
            UIView.animate(withDuration: duration, animations: {
                self.superview?.layoutIfNeeded()
                animations?()
            }, completion: { (_) in
                completion?()
            })
        }
        
        open func hide(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            self.popupView.contentHide()
            self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = 0
            UIView.animate(withDuration: duration, animations: {
                self.superview?.layoutIfNeeded()
                animations?()
            }, completion: { (_) in
                completion?()
                self.popupView.isShow = true
            })
        }
        
        @objc func backgroundTap(_ sender: UIButton) {
            self.hide()
        }
    }
}

extension UIView {
    open class PopupView: UIView {
        public let gestureButton: GestureButton = {
            let button = GestureButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        public let popupView: UIView = {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.backgroundColor = .clear
            return view
        }()

        public let navigationBar: UINavigationBar = {
            let navigationBar = UINavigationBar(frame: .zero)
            navigationBar.translatesAutoresizingMaskIntoConstraints = false
            navigationBar.isTranslucent = false
            navigationBar.pushItem(UINavigationItem(), animated: false)
            return navigationBar
        }()

        public let view: UIView = {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        open var gestureButtonColor: UIColor {
            get {
                return self.gestureButton.gestureColor
            }
            set {
                self.gestureButton.gestureColor = newValue
            }
        }

        open var gestureButtonWidth: CGFloat {
            get {
                return self.gestureButton.gestureWidth
            }
            set {
                self.gestureButton.gestureWidth = newValue
            }
        }
        
        open var gestureButtonHeight: CGFloat {
            get {
                return self.gestureButton.gestureHeight
            }
            set {
                self.gestureButton.gestureHeight = newValue
            }
        }

        open var gesturePadding: CGFloat {
            get {
                return self.gestureButton.gesturePadding
            }
            set {
                self.gestureButton.gesturePadding = newValue
            }
        }

        open var corners: UIRectCorner = [.topLeft, .topRight] {
            didSet {
                self.updateCorner()
            }
        }

        open var cornerRadius: CGFloat = 16 {
            didSet {
                self.updateCorner()
            }
        }
        
        open var isNavigationBar: Bool = true {
            didSet {
                self.navigationBar.constraints.filter({ $0.firstAttribute == .height }).first?.constant = self.isNavigationBar ? self.navigationHeight : 0
            }
        }

        open var navigationBarTintColor: UIColor = UIColor(light: UIColor(white: 248/255, alpha: 1), dark: UIColor(white: 24/255, alpha: 1)) {
            didSet {
                self.navigationBar.barTintColor = self.navigationBarTintColor
            }
        }
        
        open var viewColor: UIColor = UIColor(light: UIColor(white: 255/255, alpha: 1), dark: UIColor(white: 0/255, alpha: 1)) {
            didSet {
                self.view.backgroundColor = self.viewColor
            }
        }
        
        open var isShow: Bool {
            get {
                return (self.constraints.filter({ $0.firstAttribute == .height }).first?.constant ?? 0) != 0
            }
            set {
                self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = newValue ? self.viewHeight : 0
            }
        }
        
        open var viewHeight: CGFloat = (UIScreen.main.bounds.height / 4 * 3)
        open var isDynamicGesture = false

        private var navigationHeight: CGFloat {
            return UIApplication.shared.currentWindow?.safe.top ?? 0
        }
        
        private var dragPoint: CGPoint?

        public init() {
            super.init(frame: .zero)
            
            self.clipsToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .clear

            self.addSubview(self.popupView)
            self.addSubview(self.gestureButton)
            self.popupView.addSubview(self.navigationBar)
            self.popupView.addSubview(self.view)

            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
            ])

            self.addConstraints([
                NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.gestureButton, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.gestureButton, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.gestureButton, attribute: .trailing, multiplier: 1, constant: 0)
            ])
            
            self.addConstraints([
                NSLayoutConstraint(item: self.gestureButton, attribute: .bottom, relatedBy: .equal, toItem: self.popupView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.popupView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.popupView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.popupView, attribute: .bottom, multiplier: 1, constant: 0).priority(900)
            ])
            
            self.popupView.addConstraints([
                NSLayoutConstraint(item: self.popupView, attribute: .leading, relatedBy: .equal, toItem: self.navigationBar, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.popupView, attribute: .trailing, relatedBy: .equal, toItem: self.navigationBar, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.popupView, attribute: .top, relatedBy: .equal, toItem: self.navigationBar, attribute: .top, multiplier: 1, constant: 0)
            ])

            self.navigationBar.addConstraints([
                NSLayoutConstraint(item: self.navigationBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.navigationHeight)
            ])

            self.popupView.addConstraints([
                NSLayoutConstraint(item: self.navigationBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.popupView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.popupView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.popupView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
            
            self.navigationBar.barTintColor = self.navigationBarTintColor
            self.view.backgroundColor = self.viewColor
            
            self.gestureButton.addTarget(self, action: #selector(self.touchDown(_:forEvent:)), for: .touchDown)
            self.gestureButton.addTarget(self, action: #selector(self.touchDrag(_:forEvent:)), for: .touchDragInside)
            self.gestureButton.addTarget(self, action: #selector(self.touchUp(_:forEvent:)), for: .touchUpInside)
            self.gestureButton.addTarget(self, action: #selector(self.touchUp(_:forEvent:)), for: .touchUpOutside)
        }
        
        open func updateCorner() {
            if self.popupView.bounds.height > self.navigationHeight {
                self.popupView.roundCorners(self.corners, radius: self.cornerRadius)
            }
        }
        
        open override func layoutSubviews() {
            self.updateCorner()
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func contentShow(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = self.viewHeight
            UIView.animate(withDuration: duration, animations: {
                self.superview?.layoutIfNeeded()
                self.updateCorner()
                animations?()
            }, completion: { (_) in
                self.updateCorner()
                completion?()
            })
        }
        
        open func show(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            if let popupDimView = self.superview as? PopupDimView {
                popupDimView.show(duration, animations: animations, completion: completion)
            } else {
                self.contentShow(duration, animations: animations, completion: completion)
            }
        }
        
        func contentHide(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            self.constraints.filter({ $0.firstAttribute == .height }).first?.constant = 0
            UIView.animate(withDuration: duration, animations: {
                self.superview?.layoutIfNeeded()
                self.updateCorner()
                animations?()
            }, completion: { (_) in
                self.updateCorner()
                completion?()
            })
        }
        
        open func hide(_ duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
            if let popupDimView = self.superview as? PopupDimView {
                popupDimView.hide(duration, animations: animations, completion: completion)
            } else {
                self.contentHide(duration, animations: animations, completion: completion)
            }
        }
        
        @objc private func touchDown(_ sender: UIButton, forEvent event: UIEvent) {
            guard let touch = event.touches(for: sender)?.first else { return }
            self.dragPoint = touch.location(in: self)
        }
        
        @objc private func touchDrag(_ sender: UIButton, forEvent event: UIEvent) {
            guard let touch = event.touches(for: sender)?.first else { return }
            let previousLocation = touch.previousLocation(in: self)
            let location = touch.location(in: self)
            let pointY = location.y - previousLocation.y
            self.constraints.filter({ $0.firstAttribute == .height }).first?.constant -= pointY
        }

        @objc private func touchUp(_ sender: UIButton, forEvent event: UIEvent) {
            guard let dragPoint = self.dragPoint else { return }
            guard let touch = event.touches(for: sender)?.first else { return }
            let location = touch.location(in: self)
            if (dragPoint.y - location.y).abs < 1 {
                self.hide()
            } else if !self.isDynamicGesture {
                guard let height = self.constraints.filter({ $0.firstAttribute == .height }).first?.constant else { return }
                let previousLocation = touch.previousLocation(in: self)
                let pointY = location.y - previousLocation.y
                let isTop = pointY <= 0
                if isTop {
                    if height > self.viewHeight / 3 {
                        self.contentShow()
                    } else {
                        self.hide()
                    }
                } else {
                    if height > self.viewHeight / 6 * 5 {
                        self.contentShow()
                    } else {
                        self.hide()
                    }
                }
            }
        }
    }
}
