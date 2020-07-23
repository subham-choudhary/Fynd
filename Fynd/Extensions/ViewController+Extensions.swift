//
//  ViewController+Extensions.swift
//  Fynd
//
//  Created by user178193 on 7/24/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertWith(message: String, action: (()->Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            action?()
        }))
        present(alert, animated: true)
    }
}
