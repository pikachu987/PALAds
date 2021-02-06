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

public extension UIScrollView {
    
    var deltaOffsetY: CGFloat {
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset
    }
    
    var deltaOffsetX: CGFloat {
        let currentOffset = self.contentOffset.x
        let maximumOffset = self.contentSize.width - self.frame.size.width
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset
    }
    
    func scrollToTop(_ animated: Bool = true) {
        self.setContentOffset(CGPoint(x: 0, y: -self.contentInset.top), animated: animated)
    }
    
    func scrollToBottom(_ animated: Bool = true) {
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height), animated: animated)
    }
    
    func currentIndex(_ arraySize: Int) -> Int? {
        if arraySize != 0 && self.deltaOffsetX != 0 && self.frame.size.width != 0 {
            let index =  CGFloat(arraySize) - self.deltaOffsetX/self.frame.size.width - 1
            let cIndex = Int(round(index))
            if cIndex >= 0 && cIndex < arraySize {
                return cIndex
            }
        }
        return nil
    }
    
    func scrollFullEdgeZoom(_ imageView: UIImageView, height: CGFloat, animated: Bool = false) {
        self.setZoomScale(1, animated: false)
        let imageSize = imageView.imageFrame

        let viewHeight = height
        let viewWidth = UIScreen.main.bounds.width

        let widthRate =  viewWidth / imageSize.width
        let heightRate = viewHeight / imageSize.height

        if widthRate < heightRate {
            self.setZoomScale(heightRate, animated: animated)
        } else {
            self.setZoomScale(widthRate, animated: animated)
        }
        let xValue = self.contentSize.width/2 - self.bounds.size.width/2
        let yValue = self.contentSize.height/2 - self.bounds.size.height/2
        self.contentOffset = CGPoint(x: xValue, y: yValue)
    }
    
    func scrollViewDidZoom(_ imageView: UIImageView, height: CGFloat) {
        if self.zoomScale <= 1 {
            let offsetX = max((self.bounds.width - self.contentSize.width) * 0.5, 0)
            let offsetY = max((self.bounds.height - self.contentSize.height) * 0.5, 0)
            self.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
        } else {
            let imageSize = imageView.imageFrame

            let viewHeight = height
            let viewWidth = UIScreen.main.bounds.width

            let widthRate =  viewWidth / imageSize.width
            let heightRate = viewHeight / imageSize.height

            if widthRate < heightRate {
                let imageOffset = -imageSize.origin.y
                let scrollOffset = (self.bounds.height - self.contentSize.height) * 0.5
                if imageOffset > scrollOffset {
                    self.contentInset = UIEdgeInsets(top: imageOffset, left: 0, bottom: imageOffset, right: 0)
                } else {
                    self.contentInset = UIEdgeInsets(top: scrollOffset, left: 0, bottom: scrollOffset, right: 0)
                }
            } else {
                let imageOffset = -imageSize.origin.x
                let scrollOffset = (self.bounds.width - self.contentSize.width) * 0.5
                if imageOffset > scrollOffset {
                    self.contentInset = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0, right: imageOffset)
                } else {
                    self.contentInset = UIEdgeInsets(top: 0, left: scrollOffset, bottom: 0, right: scrollOffset)
                }
            }
        }
    }
}
