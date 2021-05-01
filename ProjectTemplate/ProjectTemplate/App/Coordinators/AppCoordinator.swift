//
//  AppCoordinator.swift
//  ProjectTemplate
//
//  Created by ha van dong on 4/30/21.
//

import UIKit

class AppCoordinator:  BaseCoordinator {
    private var window: UIWindow!
    
    init(window: UIWindow) {
        self.window = window
    }
    override func start() {
        showIntro()
    }
    
    
    func showIntro() {
        removeChildCoordinators()
        let viewController = IntroSceneFactory.IntroScene(navigator: self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: IIntroNavigator {
    
}
