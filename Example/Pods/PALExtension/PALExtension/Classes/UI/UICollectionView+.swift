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

public extension UICollectionView {
    struct Dragging {
        var velocity: CGPoint
        var targetContentOffset: UnsafeMutablePointer<CGPoint>
        var width: CGFloat
        var count: Int

        init(velocity: CGPoint, offset: UnsafeMutablePointer<CGPoint>, width: CGFloat, count: Int) {
            self.velocity = velocity
            self.targetContentOffset = offset
            self.width = width
            self.count = count
        }
    }
}

public extension UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, dragging: UICollectionView.Dragging) -> Int {
        dragging.targetContentOffset.pointee = scrollView.contentOffset
        var factor: CGFloat = 0.5
        if dragging.velocity.x < 0 { factor = -factor }
        var index = Int( round((scrollView.contentOffset.x / dragging.width) + factor) )
        if index < 0 { index = 0 }
        if index > dragging.count - 1 { index = dragging.count - 1 }
        return index
    }
}
