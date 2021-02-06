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
    open class Reward: Ads {
        public static let shared = Reward()

        private var ad: GADRewardedAd?
        private var callback: ((String?) -> Void)? = nil
        private var rewardType: String?

        public var defaultAdUnitID: String = ""
        public var defaultKey: String = ""
        public var defaultCount: Int = 0
        
        public class func update(_ adUnitID: String, defaultKey: String = "", defaultCount: Int = 1) {
            self.shared.update(adUnitID, defaultKey: defaultKey, defaultCount: defaultCount)
        }
        
        public class func load(_ viewController: UIViewController, adsType: AdsType = .default, callback: ((String?) -> Void)? = nil) {
            self.shared.load(viewController, adsType: adsType, callback: callback)
        }

        public func update(_ adUnitID: String, defaultKey: String = "", defaultCount: Int = 1) {
            self.defaultAdUnitID = adUnitID
            self.defaultKey = defaultKey
            self.defaultCount = defaultCount
        }

        public func load(_ viewController: UIViewController, adsType: AdsType = .default, callback: ((String?) -> Void)? = nil) {
            self.callback = nil
            self.viewController = nil
            self.rewardType = nil

            var adUnitID = ""
            var key = ""
            var count = 0
            if adsType == .default {
                adUnitID = self.defaultAdUnitID
                key = self.defaultKey
                count = self.defaultCount
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
                    self.adsLoad(adUnitID, callback: callback)
                } else {
                    let keyValue = UserDefaults.standard.integer(forKey: key) + 1
                    UserDefaults.standard.set(count, forKey: key)
                    UserDefaults.standard.synchronize()
                    if keyValue % count == 0 {
                        self.callback = callback
                        self.viewController = viewController
                        self.adsLoad(adUnitID, callback: callback)
                    } else {
                        callback?(nil)
                    }
                }
            }
        }
        
        private func adsLoad(_ adUnitID: String, callback: ((String?) -> Void)? = nil) {
            guard let viewController = viewController else { return }
            if self.ad != nil && self.ad?.isReady == true {
                self.statusBar(true)
                self.ad?.present(fromRootViewController: viewController, delegate: self)
            } else {
                self.ad = GADRewardedAd(adUnitID: adUnitID)
                self.ad?.load(GADRequest(), completionHandler: { [weak viewController] (error) in
                    guard let viewController = viewController else { return }
                    if self.ad?.isReady == true {
                        self.statusBar(true)
                        self.ad?.present(fromRootViewController: viewController, delegate: self)
                    } else {
                        self.callback?(nil)
                    }
                })
            }
        }
    }
}

// MARK: Ads.Reward: GADRewardedAdDelegate
extension Ads.Reward: GADRewardedAdDelegate {
    // Reward received
    public func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        self.rewardType = reward.type
    }
    
    // Rewarded ad failed to present
    public func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        self.statusBar(false)
        self.viewController = nil
    }

    // Rewarded ad to present
    public func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
    }

    // Rewarded ad dismissed
    public func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.statusBar(false)
        self.viewController = nil
        self.callback?(self.rewardType)
        self.callback = nil
    }
}

// MARK: Ads.Reward + AdsType
extension Ads.Reward {
    public enum AdsType {
        case `default`
        case custom(String, String?, Int)
        
        public static func ==(lhs: AdsType, rhs: AdsType) -> Bool {
            switch (lhs, rhs) {
            case (.default, .default):
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
            case let (.custom(adUnitID1, forKey1, count1), .custom(adUnitID2, forKey2, count2)):
                return adUnitID1 == adUnitID2 && forKey1 == forKey2 && count1 == count2
            default:
                return false
            }
        }
    }
}
