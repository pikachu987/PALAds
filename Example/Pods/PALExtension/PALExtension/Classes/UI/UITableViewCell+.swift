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

extension UITableViewCell {
    public static let bottomIndicatorCellIdentifier = BottomIndicatorCell.identifier
    public static let bottomIndicatorCell = BottomIndicatorCell.self

    // 하단 인디게이터 뷰
    open class BottomIndicatorCell: UITableViewCell {
        public static let identifier = "BottomIndicatorCell"

        public let indicatorView: UIActivityIndicatorView = {
            let indicatorView = UIActivityIndicatorView()
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            indicatorView.hidesWhenStopped = true
            indicatorView.clipsToBounds = true
            indicatorView.color = .gray
            return indicatorView
        }()

        public let heightView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.isHidden = true
            return view
        }()

        open var indicatorColor: UIColor? {
            get {
                return self.indicatorView.color
            }
            set {
                self.indicatorView.color = newValue
            }
        }

        public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            self.selectionStyle = .none
            self.clipsToBounds = true
            self.backgroundColor = .clear

            self.contentView.addSubview(self.indicatorView)
            self.contentView.addSubview(self.heightView)

            self.contentView.addConstraints([
                NSLayoutConstraint(item: self.contentView, attribute: .centerX, relatedBy: .equal, toItem: self.indicatorView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.contentView, attribute: .centerY, relatedBy: .equal, toItem: self.indicatorView, attribute: .centerY, multiplier: 1, constant: 0)
            ])

            self.contentView.addConstraints([
                NSLayoutConstraint(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self.heightView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self.heightView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self.heightView, attribute: .leading, multiplier: 1, constant: 0)
            ])

            let heightConstraint = NSLayoutConstraint(item: self.heightView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
            heightConstraint.priority = UILayoutPriority(999)

            self.heightView.addConstraints([
                NSLayoutConstraint(item: self.heightView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 0),
                heightConstraint
            ])

            self.contentView.clipsToBounds = true
            
            self.contentView.backgroundColor = UIColor(light: UIColor(white: 248/255, alpha: 1), dark: UIColor(white: 20/255, alpha: 1))
            self.indicatorView.startAnimating()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        open override func prepareForReuse() {
            super.prepareForReuse()

            self.indicatorView.startAnimating()
        }
    }
}
