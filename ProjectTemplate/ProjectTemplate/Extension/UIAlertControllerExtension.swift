//
//  UIAlertControllerExtension.swift
//  VIBChampion
//
//  Created by ha van dong on 1/25/21.
//

import UIKit

extension UIAlertController {
    
    static func showDefaultAlert(withTitle title: String?, andMessage message: String?, withButtons buttons: [String] = ["OK".localized], completion:((_ index: Int) -> Void)? = nil) -> Void {
        guard let viewController = UIApplication.shared.windows.first!.rootViewController as? UIViewController else {
            return
        }
        UIAlertController.showAlertControllerInViewController(vc: viewController, withTitle: title, andMessage: message, withButtons: buttons, completion: completion)
    }
    
    static func showActionSheet(withTitle title: String?, andMessage message: String?, withButtons buttons: [String] = ["Cancel".localized], completion:((_ index: Int) -> Void)? = nil) -> Void {
        guard let viewController = UIApplication.shared.windows.first!.rootViewController as? UIViewController else {
            return
        }

        UIAlertController.showAlertControllerInViewController(vc: viewController, type: .actionSheet, withTitle: title, andMessage: message, withButtons: buttons, completion: completion)
    }
    
    static func showAlertControllerInViewController(vc: UIViewController, type: UIAlertController.Style = .alert, withTitle title: String?, andMessage message: String?, withButtons button: [String] = ["OK".localized], completion:((_ index: Int) -> Void)? = nil) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: type)
        for index in 0 ..< button.count {
            let action = UIAlertAction(title: button[index], style: .default, handler: { (alert: UIAlertAction!) in
                guard let completion = completion else { return }
                completion(index)
            })
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true, completion: nil)
    }
}
