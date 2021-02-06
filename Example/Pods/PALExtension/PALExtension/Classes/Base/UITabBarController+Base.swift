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

extension UITabBarController {
    // 베이스 탭컨트롤러
    open class Base: UITabBarController, UITabBarControllerDelegate {
        private(set) open var isAppear = false
        private(set) open var isShowKeyboard = false

        public var statusBarHidden = false
        open override var prefersStatusBarHidden: Bool {
            return self.statusBarHidden
        }
        
        open override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }

        open override func viewDidLoad() {
            super.viewDidLoad()

            self.delegate = self
            self.view.backgroundColor = UIApplication.shared.currentWindow?.backgroundColor
            self.tabBar.isTranslucent = false
            self.initViews()
        }

        open func initViews() {
            
        }

        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.resign()
        }

        open func resign() {
            
        }

        func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, presentStyle: PresentStyle, completion: (() -> Void)? = nil) {
            viewControllerToPresent.modalPresentationStyle = presentStyle.style
            super.present(viewControllerToPresent, animated: flag, completion: completion)
        }

        open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            super.present(viewControllerToPresent, animated: flag, completion: completion)
        }

        open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            if #available(iOS 13.0, *) {
                self.isModalInPresentation = true
            }
            super.dismiss(animated: flag, completion: completion)
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.isAppear = true
        }

        open override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            self.removeNotification()
            self.addNotification()

            self.setNeedsStatusBarAppearanceUpdate()
        }

        open override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.isAppear = false
            self.removeNotification()
        }
        
        open func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
        
        // MARK: Observers
        open func addNotification() {
            Notification.addDefaultNotification(self)
        }

        open func removeNotification() {
            Notification.removeDefaultNotification(self)
        }

        open func keyboardWillChange(_ notification: Notification, keyboardSize: CGRect, safeAreaSize: CGRect) {
            
        }
        open func keyboardWillShowFrame(_ notification: Notification, keyboardSize: CGRect) {
            
        }
        open func keyboardWillHideFrame(_ notification: Notification, keyboardSize: CGRect) {
            
        }

        // 백그라운드1
        open func willResignActive(_ notification: Notification) {
            
        }
        // 백그라운드2
        open func didEnterBackground(_ notification: Notification) {
            
        }
        // 포그라운드1
        open func willEnterForeground(_ notification: Notification) {
            
        }
        // 포그라운드2
        open func didBecomeActive(_ notification: Notification) {
            
        }
        
        open func menuHide(_ notification: Notification) {
            
        }
    }
}

extension UITabBarController.Base {
    @objc override func notificationKeyboardWillShow(_ notification: Notification) {
        self.isShowKeyboard = true
        guard let sizes = notification.keyboardSize(self.view) else { return }
        self.keyboardWillChange(notification, keyboardSize: sizes.keyboard, safeAreaSize: sizes.safearea)
        self.keyboardWillShowFrame(notification, keyboardSize: sizes.keyboard)
    }

    @objc override func notificationKeyboardWillHide(_ notification: Notification) {
        self.isShowKeyboard = false
        self.keyboardWillChange(notification, keyboardSize: CGRect.zero, safeAreaSize: CGRect.zero)
        self.keyboardWillHideFrame(notification, keyboardSize: CGRect.zero)
    }

    @objc override func notificationApplicationWillResignActive(_ notification: Notification) {
        self.willResignActive(notification)
    }

    @objc override func notificationApplicationDidEnterBackground(_ notification: Notification) {
        self.didEnterBackground(notification)
    }

    @objc override func notificationApplicationWillEnterForeground(_ notification: Notification) {
        self.willEnterForeground(notification)
    }

    @objc override func notificationApplicationDidBecomeActive(_ notification: Notification) {
        self.didBecomeActive(notification)
    }
    
    @objc override func notificationMenuHide(_ notification: Notification) {
        self.menuHide(notification)
    }
}
