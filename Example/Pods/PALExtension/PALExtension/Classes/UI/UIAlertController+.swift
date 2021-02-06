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

public extension UIAlertController {
    
    var textView: UITextView? {
        guard let contentViewController = self.value(forKey: "contentViewController") as? UIViewController else { return nil }
        if contentViewController.view == nil { return nil }
        guard let textView = contentViewController.view.subviews.compactMap({ $0 as? UITextView }).first else { return nil }
        return textView
    }
    
    var datePicker: UIDatePicker? {
        guard let contentViewController = self.value(forKey: "contentViewController") as? UIViewController else { return nil }
        if contentViewController.view == nil { return nil }
        guard let datePicker = contentViewController.view.subviews.compactMap({ $0 as? UIDatePicker }).first else { return nil }
        return datePicker
    }
    
    @discardableResult
    static func alert(_ title: String? = "", message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    @discardableResult
    static func alert(_ title: String? = "", message: String?, cancelString: String, cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .alert(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
    }
    
    @discardableResult
    static func alert(_ title: String? = "", message: String?, defaultString: String, defaultHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .alert(title, message: message)
            .add(defaultString, handler: defaultHandler)
    }
    
    @discardableResult
    static func alert(_ title: String? = "", message: String?, defaultString: String, cancelString: String, defaultHandler: @escaping ((UIAlertController) -> Void), cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .alert(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
            .add(defaultString, handler: defaultHandler)
    }
    
    @discardableResult
    static func sheet(_ title: String? = "", message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    @discardableResult
    static func sheet(_ title: String? = "", message: String?, cancelString: String, cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .sheet(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
    }
    
    @discardableResult
    static func sheet(_ title: String? = "", message: String?, defaultString: String, defaultHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .sheet(title, message: message)
            .add(defaultString, handler: defaultHandler)
    }
    
    @discardableResult
    static func sheet(_ title: String? = "", message: String?, defaultString: String, cancelString: String, defaultHandler: @escaping ((UIAlertController) -> Void), cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return UIAlertController
            .sheet(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
            .add(defaultString, handler: defaultHandler)
    }
    
    private func action(_ title: String?, style: UIAlertAction.Style, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: style, handler: { [weak self] (_) in
            handler?(self ?? UIAlertController())
        }))
        return self
    }
    
    @discardableResult
    func add(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return self.action(title, style: .default, handler: handler)
    }
    
    @discardableResult
    func cancel(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return self.action(title, style: .cancel, handler: handler)
    }
    
    @discardableResult
    func destructive(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController {
        return self.action(title, style: .destructive, handler: handler)
    }
    
    @discardableResult
    func appendTextField(_ handler: ((UITextField) -> Void)? = nil) -> UIAlertController {
        self.addTextField { (textField) in
            handler?(textField)
        }
        return self
    }
    
    @discardableResult
    func appendTextView(_ textView: UITextView? = nil, handler: ((UITextView) -> Void)? = nil) -> UIAlertController {
        let textViewController = UIViewController()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var textView = textView
        if textView == nil {
            textView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        textView?.translatesAutoresizingMaskIntoConstraints = false
        textView?.layer.borderColor = UIColor(white: 210/255, alpha: 1).cgColor
        textView?.layer.borderWidth = 1
        if let textView = textView {
            handler?(textView)
            view.addSubview(textView)
            
            let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[view]-6-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": textView])
            let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[view]-6-|", options: NSLayoutConstraint.FormatOptions.alignAllLeading, metrics: nil, views: ["view": textView])
            view.addConstraints(view_constraint_H)
            view.addConstraints(view_constraint_V)
        }
        textViewController.view = view
        textViewController.preferredContentSize.height = 100
        self.setValue(textViewController, forKey: "contentViewController")
        
        return self
    }
    
    @discardableResult
    func appendDatePicker(_ handler: ((UIDatePicker) -> Void)? = nil) -> UIAlertController {
        let viewController = UIViewController()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        if let locale = (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first {
            datePicker.locale = NSLocale(localeIdentifier: locale) as Locale
        }
        datePicker.datePickerMode = .date
        
        handler?(datePicker)
        view.addSubview(datePicker)
        
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[view]-6-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": datePicker])
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[view]-6-|", options: NSLayoutConstraint.FormatOptions.alignAllLeading, metrics: nil, views: ["view": datePicker])
        view.addConstraints(view_constraint_H)
        view.addConstraints(view_constraint_V)
        viewController.view = view
        viewController.preferredContentSize.height = 300
        self.setValue(viewController, forKey: "contentViewController")
        
        return self
    }
    
    @discardableResult
    func show(_ viewController: UIViewController?) -> UIAlertController {
        DispatchQueue.main.async {
            viewController?.present(self, animated: true, completion: nil)
        }
        return self
    }
    
    @discardableResult
    func openSetting(_ title: String, handler: (() -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
            handler?()
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
            guard let url = URL(string: "\(UIApplication.openSettingsURLString)\(bundleIdentifier)") else { return }
            if !UIApplication.shared.canOpenURL(url) { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }))
        return self
    }
}
