//
//  Navigator.swift
//  ProjectTemplate
//
//  Created by dongha on 09/12/2020.
//

import UIKit

final class DefaultNavigator: INavigator {
    // MARK: - Properties
    let storyboard: UIStoryboard
    let navigationController: UINavigationController
    
    // MARK: - LifeCycle
    init(storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
}

