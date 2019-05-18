//
//  UIVCex.swift
//  GoogleBooksMVVM
//
//  Created by Jerry Zhou on 5/17/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
}
