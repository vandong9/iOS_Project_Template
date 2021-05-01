import UIKit

final class DefaultIntroLocalNavigator: IIntroLocalNavigator {
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
}

