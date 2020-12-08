//
//  ApplicationNavigator.swift
//  GoExam
//
//  Created by Dong Ha on 11/26/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

final class ApplicationNavigator {
    // MARK: - Properties
    static let shared = ApplicationNavigator()

    // MARK: - Public
    func configureMainInterface(in window: UIWindow) {        
        // Init rootNavigationController
        let rootNavigationController = UINavigationController()
        rootNavigationController.setNavigationBarHidden(true, animated: false)
        
        // Init RootViewController
        let rootViewController = UIViewController()
        rootNavigationController.pushViewController(rootViewController, animated: false)
        
        // Set rootNavigationController as rootViewController of window
        window.rootViewController = rootNavigationController
    }

}
