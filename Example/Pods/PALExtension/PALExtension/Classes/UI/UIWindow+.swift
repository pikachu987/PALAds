//
//  UIWindow.swift
//  PALBase
//
//  Created by Apple on 2021/01/16.
//

import UIKit

public extension UIWindow {
    var currentViewController: UIViewController? {
        return self.currentViewController(viewController: self.rootViewController)
    }

    private func currentViewController(viewController: UIViewController?) -> UIViewController? {
        if let viewController = viewController as? UINavigationController {
            if let currentVC = viewController.visibleViewController {
                return self.currentViewController(viewController: currentVC)
            } else {
                return viewController
            }
        } else if let viewController = viewController as? UITabBarController {
            if let currentVC = viewController.selectedViewController {
                return self.currentViewController(viewController: currentVC)
            } else {
                return viewController
            }
        } else {
            if let currentVC = viewController?.presentedViewController {
                return self.currentViewController(viewController: currentVC)
            } else {
                return viewController
            }
        }
    }
}
