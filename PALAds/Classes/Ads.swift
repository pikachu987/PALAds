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

open class Ads: NSObject {
    private static let _sharedAds = Ads()
    public class var shared: Ads {
        return self._sharedAds
    }

    public typealias Callback = (value: String?, error: Error?)
    
    private var currentWindow: UIWindow? {
        if let window = UIApplication.shared.keyWindow {
            return window
        } else {
            return UIApplication.shared.windows.first
        }
    }

    
    var callback: ((Callback) -> Void)? = nil
    
    var currentViewController: UIViewController? {
        return self.currentWindow?.currentViewController
    }
    
    open class func start(_ callback: ((GADInitializationStatus) -> Void)? = nil) {
        GADMobileAds.sharedInstance().start { (GADInitializationStatus) in
            callback?(GADInitializationStatus)
        }
    }
    
    open func shouldLoadAds(_ adUnitID: String, saveStorageKey: String, showedCount: Int) -> Bool {
        return true
    }
    
    open class func customLoad(_ adUnitID: String, saveStorageKey: String, perCount: Int, callback: ((Ads.Callback) -> Void)? = nil) {
        self.shared.load(adUnitID, saveStorageKey: saveStorageKey, perCount: perCount, callback: callback)
    }
    
    func load(_ adsData: AdsData, callback: ((Callback) -> Void)? = nil) {
        self.load(adsData.adUnitID, saveStorageKey: adsData.saveStorageKey, perCount: adsData.perCount, callback: callback)
    }
    
    func load(_ adUnitID: String, saveStorageKey: String, perCount: Int, callback: ((Callback) -> Void)? = nil) {
        if adUnitID == "" {
            fatalError("No Ad Unit ID")
        } else {
            if saveStorageKey == "" {
                self.adsLoad(adUnitID, callback: callback)
            } else {
                var saveStorageKeyValue = UserDefaults.standard.integer(forKey: saveStorageKey)
                if self.shouldLoadAds(adUnitID, saveStorageKey: saveStorageKey, showedCount: saveStorageKeyValue) {
                    saveStorageKeyValue += 1
                    UserDefaults.standard.set(saveStorageKeyValue, forKey: saveStorageKey)
                    UserDefaults.standard.synchronize()
                    if saveStorageKeyValue % perCount == 0 {
                        self.adsLoad(adUnitID, callback: callback)
                    } else {
                        callback?((value: nil, error: nil))
                    }
                } else {
                    callback?((value: nil, error: nil))
                }
            }
        }
    }
    
    func adsLoad(_ adUnitID: String, callback: ((Callback) -> Void)? = nil) {
        
    }
}

// MARK: Ads + AdsData
extension Ads {
    public struct AdsData {
        public var adUnitID: String
        public var saveStorageKey: String
        public var perCount: Int

        public init(adUnitID: String = "", saveStorageKey: String = "", perCount: Int = 0) {
            self.adUnitID = adUnitID
            self.saveStorageKey = saveStorageKey
            self.perCount = perCount
        }
        
        public mutating func update(adUnitID: String = "", saveStorageKey: String = "", perCount: Int = 0) {
            self.adUnitID = adUnitID
            self.saveStorageKey = saveStorageKey
            self.perCount = perCount
        }
    }
}

fileprivate extension UIWindow {
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
