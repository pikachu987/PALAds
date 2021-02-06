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

public extension UITableView {
    var sectionView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.minimum))
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }

    func sectionView(color: UIColor, height: CGFloat) -> UIView {
        let sectionView = self.sectionView
        sectionView.backgroundColor = color
        sectionView.frame.size.height = height
        return sectionView
    }

    func sectionView(text: String, textColor: UIColor  = UIColor(light: UIColor(white: 150/255, alpha: 1), dark: UIColor(white: 110/255, alpha: 1)), backgroundColor: UIColor = UIColor(light: UIColor(white: 248/255, alpha: 1), dark: UIColor(white: 20/255, alpha: 1)), height: CGFloat = 40) -> UIView {
        let sectionView = self.sectionView(color: backgroundColor, height: height)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(label)
        sectionView.addConstraints([
            NSLayoutConstraint(item: sectionView, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: sectionView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sectionView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        label.text = text
        label.font = .systemFont(ofSize: 15)
        label.textColor = textColor
        sectionView.addLineView(.bottom, color: UIColor(light: UIColor(white: 240/255, alpha: 1), dark: UIColor(white: 27/255, alpha: 1)), size: 1)
        return sectionView
    }

    func sectionView(text: String, button: UIButton, textColor: UIColor  = UIColor(light: UIColor(white: 150/255, alpha: 1), dark: UIColor(white: 110/255, alpha: 1)), backgroundColor: UIColor = UIColor(light: UIColor(white: 248/255, alpha: 1), dark: UIColor(white: 20/255, alpha: 1)), height: CGFloat = 40) -> UIView {
        let sectionView = self.sectionView(color: backgroundColor, height: height)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(label)
        sectionView.addSubview(button)
        sectionView.addConstraints([
            NSLayoutConstraint(item: sectionView, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: sectionView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sectionView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        sectionView.addConstraints([
            NSLayoutConstraint(item: sectionView, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: sectionView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sectionView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        label.text = text
        label.font = .systemFont(ofSize: 15)
        label.textColor = textColor

        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)

        sectionView.addLineView(.bottom, color: UIColor(light: UIColor(white: 240/255, alpha: 1), dark: UIColor(white: 27/255, alpha: 1)), size: 1)
        return sectionView
    }
    
    func chatKeyboardShow(_ view: UIView, notification: Notification? = nil, bottomConstraint: NSLayoutConstraint) {
        var animationDuration: Double = 0.3
        var animationOptions: AnimationOptions = [.beginFromCurrentState]
        var newBottomConstraint: CGFloat? = nil
        
        if let notification = notification {
            guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            guard let rawAnimation = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
            
            newBottomConstraint = UIScreen.main.bounds.size.height - keyboardEndFrame.origin.y
            animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
            animationOptions = [.beginFromCurrentState, UIView.AnimationOptions(rawValue: UInt( (rawAnimation.uint32Value << 16) ))]
        }
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
            if let newBottomConstraint = newBottomConstraint {
                bottomConstraint.constant = newBottomConstraint
            }
            view.layoutIfNeeded()
            let newTableViewHeight = self.bounds.size.height
            var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
            newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
            newYContentOffset = max(CGFloat(0), newYContentOffset)
            self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
        }, completion: nil)
    }
    
    func chatKeyboardHideRow(_ view: UIView, notification: Notification? = nil, bottomConstraint: NSLayoutConstraint, lastRowIndex: Int) {
        var animationDuration: Double = 0.3
        var animationOptions: AnimationOptions = [.beginFromCurrentState]
        var newBottomConstraint: CGFloat? = nil
        
        if let notification = notification {
            guard let rawAnimation = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
            
            newBottomConstraint = 0
            animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
            animationOptions = [.beginFromCurrentState, UIView.AnimationOptions(rawValue: UInt( (rawAnimation.uint32Value << 16) ))]
        }
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
            if let newBottomConstraint = newBottomConstraint {
                bottomConstraint.constant = newBottomConstraint
            }
            view.layoutIfNeeded()
            if Int(floor(self.contentSize.height-self.bounds.height)) - 10 > Int(floor(self.contentOffset.y)) {
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            } else {
                if lastRowIndex >= 0{
                    self.scrollToRow(at: IndexPath(row: lastRowIndex, section: 0), at: .bottom, animated: false)
                }
            }
        }, completion: nil)
    }
    
    func chatKeyboardHideSection(_ view: UIView, notification: Notification? = nil, bottomConstraint: NSLayoutConstraint, lastSectionIndex: Int) {
        var animationDuration: Double = 0.3
        var animationOptions: AnimationOptions = [.beginFromCurrentState]
        var newBottomConstraint: CGFloat? = nil
        
        if let notification = notification {
            guard let rawAnimation = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
            
            newBottomConstraint = 0
            animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
            animationOptions = [.beginFromCurrentState, UIView.AnimationOptions(rawValue: UInt( (rawAnimation.uint32Value << 16) ))]
        }
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
            if let newBottomConstraint = newBottomConstraint {
                bottomConstraint.constant = newBottomConstraint
            }
            view.layoutIfNeeded()
            if Int(floor(self.contentSize.height-self.bounds.height)) - 10 > Int(floor(self.contentOffset.y)) {
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            } else {
                if lastSectionIndex >= 0{
                    self.scrollToRow(at: IndexPath(row: 0, section: lastSectionIndex), at: .bottom, animated: false)
                }
            }
        }, completion: nil)
    }
    
    func chatKeyboardDynamicHeight(_ changeBetweenValue: CGFloat, animated: Bool = false) {
        let offsetY = self.contentOffset.y
        self.setContentOffset(CGPoint(x: self.contentOffset.x, y: offsetY-changeBetweenValue), animated: animated)
    }
}

