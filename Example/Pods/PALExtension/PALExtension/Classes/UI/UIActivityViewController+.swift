//
//  UIActivityViewController+Status.swift
//  Doctalk
//
//  Created by APPLE on 2020/03/16.
//  Copyright © 2020 docfriends. All rights reserved.
//

import UIKit

extension UIActivityViewController {
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let navigationController = UIApplication.shared.currentViewController?.navigationController {
            navigationController.setNeedsStatusBarAppearanceUpdate()
        } else if let navigationController = UIApplication.shared.currentViewController?.tabBarController?.navigationController {
            navigationController.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
