//
//  UIViewController+Alert.swift
//  GNB Trades
//
//  Created by Lang Troyan on 11/09/2019.
//  Copyright © 2019 Lang Troyan. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert, completition: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default){
            (action) in
            completition()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
