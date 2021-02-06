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

import Foundation

public extension Notification {
    var duration: TimeInterval {
        guard let duration = self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return 0.23 }
        return duration
    }

    var curve: UIView.AnimationOptions {
        guard let curve = self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return UIView.AnimationOptions.curveEaseIn }
        return UIView.AnimationOptions(rawValue: curve)
    }
}

extension Notification {
    
    typealias KeyboardSizes = (keyboard: CGRect, safearea: CGRect)

    func keyboardSize(_ view: UIView) -> KeyboardSizes? {
        guard let keyboardSize1 = ((self as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return nil }
        guard let keyboardSize2 = ((self as NSNotification).userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return nil }
        let keyboardSize = keyboardSize1.height == 0 ? keyboardSize2 : keyboardSize1
        var safeAreaSize = keyboardSize
        if #available(iOS 11.0, *) {
            safeAreaSize.size.height = safeAreaSize.height - view.safe.bottom
        }
        return (keyboard: keyboardSize, safearea: safeAreaSize)
    }

    static func addDefaultNotification(_ viewController: UIViewController) {
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationApplicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationApplicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationApplicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationApplicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.notificationMenuHide(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    static func removeDefaultNotification(_ viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIMenuController.willHideMenuNotification, object: nil)
    }
}

extension UIViewController {
    @objc func notificationKeyboardWillShow(_ notification: Notification) {
        
    }

    @objc func notificationKeyboardWillHide(_ notification: Notification) {
        
    }

    @objc func notificationApplicationWillResignActive(_ notification: Notification) {
        
    }

    @objc func notificationApplicationDidEnterBackground(_ notification: Notification) {
        
    }

    @objc func notificationApplicationWillEnterForeground(_ notification: Notification) {
        
    }

    @objc func notificationApplicationDidBecomeActive(_ notification: Notification) {
        
    }
    
    @objc func notificationMenuHide(_ notification: Notification) {

    }
}
