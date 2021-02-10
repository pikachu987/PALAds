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

extension Ads {
    open class Interstitial: Ads {
        public static let shared = Interstitial()

        private var ad: GADInterstitial?
        private var callback: (() -> Void)? = nil
        
        public var defaultAdUnitID: String = ""
        public var defaultKey: String = ""
        public var defaultCount: Int = 0

        public var initialAdUnitID: String = ""
        public var initialKey: String = ""
        public var initialCount: Int = 0

        open class func update(_ adUnitID: String, defaultKey: String, defaultCount: Int = 5) {
            self.shared.update(adUnitID, defaultKey: defaultKey, defaultCount: defaultCount)
        }

        open class func updateInitial(_ adUnitID: String, defaultKey: String, defaultCount: Int = 5) {
            self.shared.updateInitial(adUnitID, defaultKey: defaultKey, defaultCount: defaultCount)
        }

        open class func load(_ viewController: UIViewController, adsType: AdsType, callback: (() -> Void)? = nil) {
            self.shared.load(viewController, adsType: adsType, callback: callback)
        }

        open func update(_ adUnitID: String, defaultKey: String, defaultCount: Int = 5) {
            self.defaultAdUnitID = adUnitID
            self.defaultKey = defaultKey
            self.defaultCount = defaultCount
        }
        
        open func updateInitial(_ adUnitID: String, defaultKey: String, defaultCount: Int = 3) {
            self.initialAdUnitID = adUnitID
            self.initialKey = defaultKey
            self.initialCount = defaultCount
        }
        
        open func load(_ viewController: UIViewController, adsType: AdsType, callback: (() -> Void)? = nil) {
            var adUnitID = ""
            var key = ""
            var count = 0
            if adsType == .default {
                adUnitID = self.defaultAdUnitID
                key = self.defaultKey
                count = self.defaultCount
            } else if adsType == .initial {
                adUnitID = self.initialAdUnitID
                key = self.initialKey
                count = self.initialCount
            } else if case let .custom(customAdUnitID, customKey, customCount) = adsType {
                adUnitID = customAdUnitID
                key = customKey ?? ""
                count = customCount
            }
            if adUnitID == "" {
                fatalError("No Ad Unit ID")
            } else {
                if key == "" {
                    self.callback = callback
                    self.viewController = viewController
                    self.adsLoad(adUnitID)
                } else {
                    let keyValue = UserDefaults.standard.integer(forKey: key) + 1
                    UserDefaults.standard.set(keyValue, forKey: key)
                    UserDefaults.standard.synchronize()
                    if keyValue % count == 0 {
                        self.callback = callback
                        self.viewController = viewController
                        self.adsLoad(adUnitID)
                    } else {
                        callback?()
                    }
                }
            }
        }
        
        private func adsLoad(_ adUnitID: String) {
            self.statusBar(true)
            self.ad = GADInterstitial(adUnitID: adUnitID)
            self.ad?.delegate = self
            self.ad?.load(GADRequest())
        }
    }
}

// MARK: Ads.Interstitial: GADInterstitialDelegate
extension Ads.Interstitial: GADInterstitialDelegate {
    // Tells the delegate an ad request succeeded.
    public func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        guard let viewController = self.viewController else { return }
        if ad.isReady {
            ad.present(fromRootViewController: viewController)
        }
    }

    // Tells the delegate an ad request failed.
    public func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        self.statusBar(false)
        self.viewController = nil
        self.callback?()
        self.callback = nil
    }

    // Tells the delegate the interstitial had been animated off the screen.
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.statusBar(false)
        self.viewController = nil
        self.callback?()
        self.callback = nil
    }

    // Tells the delegate that an interstitial will be presented.
    public func interstitialWillPresentScreen(_ ad: GADInterstitial) { }

    // Tells the delegate the interstitial is to be animated off the screen.
    public func interstitialWillDismissScreen(_ ad: GADInterstitial) { }

    // Tells the delegate that a user click will open another app
    // (such as the App Store), backgrounding the current app.
    public func interstitialWillLeaveApplication(_ ad: GADInterstitial) { }
}

// MARK: Ads.Interstitial + AdsType
extension Ads.Interstitial {
    public enum AdsType {
        case `default`
        case initial
        case custom(String, String?, Int)
        
        public static func ==(lhs: AdsType, rhs: AdsType) -> Bool {
            switch (lhs, rhs) {
            case (.default, .default):
                return true
            case (.initial, .initial):
                return true
            case (.custom, .custom):
                return true
            default:
                return false
            }
        }
        
        public static func ===(lhs: AdsType, rhs: AdsType) -> Bool {
            switch (lhs, rhs) {
            case (.default, .default):
                return true
            case (.initial, .initial):
                return true
            case let (.custom(adUnitID1, forKey1, count1), .custom(adUnitID2, forKey2, count2)):
                return adUnitID1 == adUnitID2 && forKey1 == forKey2 && count1 == count2
            default:
                return false
            }
        }
    }
}
