//
//  UIViewController+Extensions.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 26.07.20.
//

import UIKit

extension UIViewController {
    
    func displayAlert(with title: String, message: String? = nil, actions: [UIAlertAction]? = nil) {
        
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
}
