import Foundation

class IntroSceneFactory {
    class func IntroScene(navigator: IIntroNavigator) -> IntroViewController {
        let vc = IntroViewController.init(nibName: "IntroViewController", bundle: nil)
        vc.viewModel = IntroViewModel(repository: DefaultIntroRepository(), navigator: navigator)
        return vc
    }
    
    class func IntroScene(navigator: IIntroNavigator, navigationController: BaseNavigationController) -> IntroViewController {
        let vc = IntroViewController()
        vc.viewModel = IntroViewModel(repository: DefaultIntroRepository(), navigator: navigator, localNavigator: DefaultIntroLocalNavigator(navigationController: navigationController))
        return vc
    }
}
