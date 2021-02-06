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
import GoogleMobileAds
import PALExtension

open class Ads: NSObject {
    public weak var viewController: UIViewController?
    
    open class func start(_ callback: ((GADInitializationStatus) -> Void)? = nil) {
        GADMobileAds.sharedInstance().start { (GADInitializationStatus) in
            callback?(GADInitializationStatus)
        }
    }

    open func statusBar(_ isHidden: Bool) {
        if self.viewController as? UIViewController.Base != nil {
            (self.viewController as? UIViewController.Base)?.statusBarHidden = isHidden
            ((self.viewController as? UIViewController.Base)?.navigationController as? UINavigationController.Base)?.statusBarHidden = isHidden
        } else if self.viewController as? UINavigationController.Base != nil {
            (self.viewController as? UINavigationController.Base)?.statusBarHidden = isHidden
        } else if self.viewController as? UITabBarController.Base != nil {
            (self.viewController as? UITabBarController.Base)?.statusBarHidden = isHidden
            ((self.viewController as? UITabBarController.Base)?.navigationController as? UINavigationController.Base)?.statusBarHidden = isHidden
        }
        self.viewController?.setNeedsStatusBarAppearanceUpdate()
    }
}
