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
        private static let _sharedInterstitial = Interstitial()
        open override class var shared: Ads {
            return self._sharedInterstitial
        }

        public static var property = AdsProperty()
        
        private var ad: GADInterstitialAd?
        
        open class func initialLoad(_ callback: ((Ads.Callback) -> Void)? = nil) {
            self.shared.load(self.property.initial, callback: callback)
        }

        open class func defaultLoad(_ callback: ((Ads.Callback) -> Void)? = nil) {
            self.shared.load(self.property.default, callback: callback)
        }
        
        override func adsLoad(_ adUnitID: String, callback: ((Ads.Callback) -> Void)? = nil) {
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: adUnitID, request: request, completionHandler: { [weak self] (ad, error) in
                if let error = error {
                    callback?((value: nil, error: error))
                    return
                }
                guard let self = self, let ad = ad, let currentViewController = self.currentViewController else {
                    callback?((value: nil, error: NSError(domain: "Error Ad", code: 503, userInfo: nil) as Error))
                    return
                }
                self.callback = callback
                self.ad = ad
                self.ad?.fullScreenContentDelegate = self
                self.ad?.present(fromRootViewController: currentViewController)
            })
        }
    }
}

// MARK: Ads.Interstitial: GADFullScreenContentDelegate
extension Ads.Interstitial: GADFullScreenContentDelegate {
    public func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
    }
    
    public func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.callback?((value: nil, error: error))
        self.callback = nil
        self.ad = nil
    }

    public func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    }
    
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.callback?((value: self.ad?.adUnitID, error: nil))
        self.callback = nil
        self.ad = nil
    }
}

// MARK: Ads.Interstitial + AdsProperty
extension Ads.Interstitial {
    public struct AdsProperty {
        public var `default` = AdsData()
        public var initial = AdsData()
    }
}
