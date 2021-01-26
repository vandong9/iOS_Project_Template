//
//  UIStoryboardExtension.swift
//  AppTemplate
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T? where T: UIViewController {
        guard let className = type.description().components(separatedBy: ".").last, let viewController = instantiateViewController(withIdentifier: String(className)) as? T else {
            return nil
        }
        return viewController
    }
}
