//
//  UIApplication.swift
//  PALBase
//
//  Created by Apple on 2021/01/16.
//

import UIKit

public extension UIApplication {
    var currentWindow: UIWindow? {
        if let window = self.keyWindow {
            return window
        } else {
            return self.windows.first
        }
    }

    var currentViewController: UIViewController? {
        return self.currentWindow?.currentViewController
    }

    static func transitionViewController(viewController: UIViewController, duration: TimeInterval = 0.3, options: UIView.AnimationOptions = .transitionCrossDissolve, handler: (() -> Void)? = nil) {
        let frame = UIApplication.shared.currentWindow?.rootViewController?.view.frame
        UIApplication.shared.currentWindow?.rootViewController?.dismiss(animated: false, completion: nil)
        guard let window = UIApplication.shared.currentWindow else { return }
        viewController.view.frame = frame ?? UIScreen.main.bounds
        viewController.view.layoutIfNeeded()
        if duration == 0 {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            handler?()
        } else {
            UIView.transition(with: window, duration: duration, options: options, animations: {
                window.rootViewController?.view.alpha = 0
                window.rootViewController = viewController
            }, completion: { _ in
                window.makeKeyAndVisible()
                handler?()
            })
        }
    }
}

